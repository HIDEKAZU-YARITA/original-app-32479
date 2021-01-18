class TopController < ApplicationController
  def index
    @staffs = Staff.where.not(id: 0)
  end
end
