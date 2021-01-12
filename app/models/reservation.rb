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

  def self.check(reservation)
    @reservations = Reservation.where(staff_id: reservation.staff_id)
    business_hours_end_time = DateTime.new(reservation.start_time.year, reservation.start_time.mon, reservation.start_time.day, 18, 00)
    break_flag = 0
    if reservation.start_time < DateTime.now    # 過去
      break_flag = 4
    elsif reservation.start_time.wday == 2      # 火曜日
      break_flag = 3
    elsif reservation.end_time > business_hours_end_time    # 終了時刻が営業時間外
      break_flag = 2
    else
      unless @reservations.blank?
        @reservations.each do |f|
          unless reservation.start_time >= f.end_time || reservation.end_time <= f.start_time   # 予約あり
            break_flag = 1
          end
        end
      end
    end
    return break_flag
  end
end
