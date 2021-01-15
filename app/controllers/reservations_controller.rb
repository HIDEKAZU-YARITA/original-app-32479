class ReservationsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_staffs, only: [:index, :show]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @menu = Menu.find(@reservation.menu_id)
    @reservation.end_time = @reservation.start_time + @menu.time * 60 * 60
    return_value = Reservation.check(@reservation)
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
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_time, :menu_id, :staff_id).merge(customer_id: current_customer.id)
  end

  def set_staffs
    @staffs = Staff.where.not(id: 0)
  end
end
