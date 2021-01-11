class Reservation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :menu
  belongs_to :staff

  belongs_to  :customer

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  with_options presence: true, numericality: { other_than: 0, message: 'must be selected.' } do
    validates :menu_id
    validates :staff_id
  end

  def date_before_start
    return if start_time.blank?
    errors.add(:start_time, "は今日以降のものを選択してください") if start_time < Date.today
  end
end
