class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(current_customer.id)
    @reservations = Reservation.where(customer_id: current_customer.id).limit(5).order(start_time: 'DESC')
  end
end
