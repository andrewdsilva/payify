module Payify
  class PaymentSerializer < ActiveModel::Serializer
    attributes :id, :amount, :status, :payment_method, :transaction_id, :paid_at

    attributes :stripe_payment_inent_id, :stripe_client_secret

    attribute(:paid) { object.paid? }
    attribute(:can_destroy) { object.can_destroy? }
  end
end
