FactoryBot.define do
  factory :reservation do
    start_time do
      DateTime.new(DateTime.now.next_week(:wednesday).year, DateTime.now.next_week(:wednesday).mon,
                   DateTime.now.next_week(:wednesday).day, 8, 0)
    end
    end_time              { start_time + 1.0.hour }
    menu_id               { 1 }
    staff_id              { 1 }
    association :customer
  end
end
