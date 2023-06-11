module Payify
  class Payment < ApplicationRecord
    enum status: { pending: 0, paid: 1, failed: 2 }
    enum payment_method: { stripe: 0 }

    belongs_to :model, polymorphic: true

    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :status, presence: true
  end
end
