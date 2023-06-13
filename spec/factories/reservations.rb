FactoryBot.define do
  factory :reservation_1, class: Reservation do
    price { 1500 }
    created_at { 1.days.ago }
  end
end
