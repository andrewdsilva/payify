require "stripe/client"

module Payify
  module StripePaymentConcern
    extend ActiveSupport::Concern

    def stripe_client
      @stripe_client ||= Stripe::Client.new
    end

    def stripe_init_intent
      return unless stripe_payment_inent_id.nil? && !paid?

      intent = stripe_client.create_payment_intent(amount)

      update_attribute(:stripe_payment_inent_id, intent.id)
    end

    def stripe_confirm_payment
    end
  end
end
