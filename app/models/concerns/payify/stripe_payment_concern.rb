require "stripe_api/client"

module Payify
  module StripePaymentConcern
    extend ActiveSupport::Concern

    def stripe_client
      @stripe_client ||= StripeApi::Client.new
    end

    def stripe_init_intent
      return unless stripe_payment_inent_id.nil? && !paid?

      intent = stripe_client.create_payment_intent(amount, tax_id)

      update_attribute(:stripe_payment_inent_id, intent.id)
      update_attribute(:stripe_client_secret, intent.client_secret)
    end

    def stripe_confirm_payment
      intent = stripe_client.find_intent(stripe_payment_inent_id)

      return unless intent["status"] == "succeeded"

      update_attribute(:paid_at, Time.now)
      update_attribute(:status, Payify::Payment.statuses[:paid])
    end

    def tax_id
      model&.tax_rates_id || Payify.default_tax_rates_id
    end
  end
end
