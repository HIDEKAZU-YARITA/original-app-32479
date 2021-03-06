class ReservationsController < ApplicationController
  before_action :authenticate_customer!, except: :index
  before_action :set_staffs, except: :destroy
  before_action :set_reservation, only: [:show, :edit, :destroy]
  before_action :move_to_index, only: [:edit]
  before_action :set_end_time, only: [:create, :update]

  def new
    @reservation = Reservation.new
  end

  def create
    @customer_reservations = Reservation.where(customer_id: @reservation.customer.id).where(start_time: @search_date.in_time_zone.all_day)
    @staff_reservations = Reservation.where(staff_id: @reservation.staff_id).where(start_time: @search_date.in_time_zone.all_day)
    return_value = Reservation.check(@reservation, @customer_reservations, @staff_reservations, @business_hours_end_time)
    case return_value
    when 0 then
      if @reservation.save
        redirect_to reservations_path(id: @reservation.staff.id)
      else
        render :new
      end
    when 1 then
      @reservation.errors.add(:start_time, ': you already have your reservation.')
      render :new
    when 2 then
      @reservation.errors.add(:start_time, 'is already scheduled.')
      render :new
    when 3 then
      @reservation.errors.add(:end_time, 'is outside business hours.')
      render :new
    when 4 then
      @reservation.errors.add(:start_time, 'is holiday.')
      render :new
    when 5 then
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
    @customer_reservations = Reservation.where(customer_id: @reservation.customer.id).where(start_time: @search_date.in_time_zone.all_day).where.not(id: @pre_reservation.id)
    @staff_reservations = Reservation.where(staff_id: @reservation.staff_id).where(start_time: @search_date.in_time_zone.all_day).where.not(id: @pre_reservation.id)
    return_value = Reservation.check(@reservation, @customer_reservations, @staff_reservations, @business_hours_end_time)
    case return_value
    when 0 then
      if @pre_reservation.update(start_time: @reservation.start_time, end_time: @reservation.end_time,
                                 staff_id: @reservation.staff_id, menu_id: @reservation.menu_id)
        redirect_to reservations_path(id: @reservation.staff.id)
      else
        render :edit
      end
    when 1 then
      @reservation.errors.add(:start_time, ': you already have your reservation.')
      render :edit
    when 2 then
      @reservation.errors.add(:start_time, 'is already scheduled.')
      render :edit
    when 3 then
      @reservation.errors.add(:end_time, 'is outside business hours.')
      render :edit
    when 4 then
      @reservation.errors.add(:start_time, 'is holiday.')
      render :edit
    when 5 then
      @reservation.errors.add(:start_time, 'is the past.')
      render :edit
    end
  end

  def destroy
    if @reservation.start_time > DateTime.now
      @reservation.destroy
      redirect_to staffs_path and return
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
    @search_date = DateTime.new(@reservation.start_time.year, @reservation.start_time.mon, @reservation.start_time.day, 0, 0, 0,
                                '+09:00')
    @business_hours_end_time = DateTime.new(@search_date.year, @search_date.mon, @search_date.day, 18, 0, 0, '+09:00')
  end
end
