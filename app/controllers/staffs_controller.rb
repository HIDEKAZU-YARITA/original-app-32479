class StaffsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @staffs = Staff.where.not(id: 0)
    @reservations = Reservation.where('start_time >= ?', Date.today).order(start_time: 'ASC')
  end
end
