FactoryBot.define do
  factory :payment_1, class: Payify::Payment do
    amount { 1500 }
    status { Payify::Payment.status[:pending] }
    payment_method { Payify::Payment.payment_methods[:stripe] }
    transaction_id { nil }
    paid_at { nil }
  end
end
