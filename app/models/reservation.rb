class Reservation < ApplicationRecord
  belongs_to  :customer

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  with_options numericality: { other_than: 0, message: 'must be selected.' } do
    validates :menu_id
    validates :staff_id
  end
end
