class Reservation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :menu
  belongs_to :staff

  belongs_to :customer

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  with_options presence: true, numericality: { other_than: 0, message: 'must be selected.' } do
    validates :menu_id
    validates :staff_id
  end

  def self.check(reservation, customer_reservations, staff_reservations, business_hours_end_time)
    reservation.valid?
    break_flag = 0
    if reservation.start_time < DateTime.now    # 過去
      break_flag = 5
    elsif reservation.start_time.wday == 2      # 火曜日
      break_flag = 4
    elsif reservation.end_time > business_hours_end_time # 終了時刻が営業時間外
      break_flag = 3
    elsif !staff_reservations.blank?
      staff_reservations.each do |f|
        break_flag = 2 unless reservation.start_time >= f.end_time || reservation.end_time <= f.start_time # スタッフに予約あり
      end
    else !customer_reservations.blank?
      customer_reservations.each do |f|
        break_flag = 1 unless reservation.start_time >= f.end_time || reservation.end_time <= f.start_time # お客様に予約あり
      end
    end
    break_flag
  end
end
