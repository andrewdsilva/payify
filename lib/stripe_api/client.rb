module StripeApi
  class Client
    def initialize
      stripe

      ::Stripe.api_key = Payify.stripe_api_key
    end

    def stripe
      @stripe ||= ::Stripe::StripeClient.new
    end

    def create_payment_intent(amount, tax_id = nil, object_invoice = "")
      infos = {
        amount: (amount * 100).to_i,
        currency: Payify.currency,
        description: object_invoice,
        setup_future_usage: "off_session",
        metadata: {
          "tax_id": tax_id
        }
      }

      Stripe::PaymentIntent.create(infos)
    end

    def find_intent(payment_intent_id)
      Stripe::PaymentIntent.retrieve(payment_intent_id)
    end
  end
end
