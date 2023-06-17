module Payify
  class Payment < ApplicationRecord
    include ::Payify::StripePaymentConcern

    enum status: { pending: 0, paid: 1, failed: 2 }
    enum payment_method: { stripe: 0 }

    belongs_to :model, polymorphic: true, optional: true

    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :status, presence: true

    before_destroy :cannot_destroy_if_paid

    def make_payment(transaction_id)
      self.transaction_id = transaction_id
      self.paid_at = Time.current
      self.status = :paid
    end

    def can_destroy?
      !paid?
    end

    def paid?
      paid_at.present?
    end

    private

    def cannot_destroy_if_paid
      raise ActiveRecord::RecordNotDestroyed if paid?
    end
  end
end
