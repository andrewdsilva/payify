module Payify
  module HasPaymentConcern
    extend ActiveSupport::Concern

    included do
      has_one :payment, as: :model, dependent: :destroy
    end

    def create_payment
      build_payment
    end

    def cancel_payment
      payment.destroy if payment.present?
    end

    def amount_to_pay
      raise NotImplementedError, "The 'amount_to_pay' method must be implemented in the including model."
    end

    def tax_rates_id
      nil
    end
  end
end
