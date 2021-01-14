class StaffsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @staffs = Staff.where.not(id: 0)
  end
end
