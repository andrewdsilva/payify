module Stripe
  class Client
    def initialize
      stripe

      Stripe.api_key = Rails.application.secrets.stripe_api_key
    end

    def stripe
      @stripe ||= Stripe::StripeClient.new
    end

    def create_payment_intent(amount, object_invoice = "")
      infos = {
        amount: amount,
        currency: config.payify.currency,
        description: object_invoice,
        setup_future_usage: "off_session"
      }

      Stripe::PaymentIntent.create(infos)
    end
  end
end
