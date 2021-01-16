class ReservationsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_staffs, only: [:index, :show]
  before_action :set_reservation, only: [:show, :edit, :destroy]
  before_action :move_to_index, only: [:edit]
  before_action :set_end_time, only: [:create, :update]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservations = Reservation.where(staff_id: @reservation.staff_id).where(start_time: @search_date.in_time_zone.all_day)
    return_value = Reservation.check(@reservation, @reservations, @business_hours_end_time)
    if return_value == 0
      if @reservation.save
        redirect_to reservations_path(id: @reservation.staff.id)
      else
        render :new
      end
    elsif return_value == 1
      @reservation.errors.add(:start_time, 'is already scheduled.')
      render :new
    elsif return_value == 2
      @reservation.errors.add(:end_time, 'is outside business hours.')
      render :new
    elsif return_value == 3
      @reservation.errors.add(:start_time, 'is holiday.')
      render :new
    elsif return_value == 4
      @reservation.errors.add(:start_time, 'is the past.')
      render :new
    end
  end

  def index
    @staff = Staff.find(params[:id])
    @reservations = Reservation.where(staff_id: @staff.id).where('start_time >= ?', Date.today).order(start_time: 'ASC')
  end

  def show
  end

  def edit
    redirect_to reservations_path(id: @reservation.staff.id) if @reservation.start_time < DateTime.now
  end

  def update
    @pre_reservation = Reservation.find(params[:id])
    @reservations = Reservation.where(staff_id: @reservation.staff_id).where(start_time: @search_date.in_time_zone.all_day).where.not(id: @pre_reservation.id)
    return_value = Reservation.check(@reservation, @reservations, @business_hours_end_time)
    if return_value == 0
      if @pre_reservation.update(start_time: @reservation.start_time, end_time: @reservation.end_time, staff_id: @reservation.staff_id, menu_id: @reservation.menu_id)
        redirect_to reservations_path(id: @reservation.staff.id)
      else
        render :edit
      end
    elsif return_value == 1
      @reservation.errors.add(:start_time, 'is already scheduled.')
      render :edit
    elsif return_value == 2
      @reservation.errors.add(:end_time, 'is outside business hours.')
      render :edit
    elsif return_value == 3
      @reservation.errors.add(:start_time, 'is holiday.')
      render :edit
    elsif return_value == 4
      @reservation.errors.add(:start_time, 'is the past.')
      render :edit
    end
  end

  def destroy
    if @reservation.start_time > DateTime.now
      @pre_reservation = @reservation
      @reservation.destroy
      redirect_to reservations_path(id: @pre_reservation.staff.id) and return
    else
      redirect_to reservations_path(id: @reservation.staff.id) and return
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_time, :menu_id, :staff_id).merge(customer_id: current_customer.id)
  end

  def set_staffs
    @staffs = Staff.where.not(id: 0)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless @reservation.customer.id == current_customer.id
  end

  def set_end_time
    @reservation = Reservation.new(reservation_params)
    @menu = Menu.find(@reservation.menu_id)
    @reservation.end_time = @reservation.start_time + @menu.time * 60 * 60
    @search_date = DateTime.new(@reservation.start_time.year, @reservation.start_time.mon, @reservation.start_time.day, 0, 0, 0,'+09:00')
    @business_hours_end_time = DateTime.new(@search_date.year, @search_date.mon, @search_date.day, 18, 0, 0, '+09:00')
  end
end
