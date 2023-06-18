require "rails_helper"

RSpec.describe "Payify::PaymentControllers", type: :request do
  describe "GET #new" do
    it "New payment form" do
      payment = create(:payment_1)

      get "/payments/#{payment.id}/new", params: { id: payment.id }

      expect(response).to render_template("payify/payments/new")
    end

    it "New payment (api)" do
      payment = create(:payment_1)

      get "/payments/#{payment.id}/new.json", params: { id: payment.id }

      expect(response).to have_http_status(200)
      expect(json["paid"]).to eq(false)
      expect(json["stripe_client_secret"]).not_to eq(nil)
    end
  end

  describe "Make payment" do
    it "calls pay_with_stripe on the payment" do
      payment = create(:payment_1)
      payment.stripe_init_intent

      # Status is pending before payment
      get "/payments/#{payment.id}/complete"

      expect(payment.reload.status).to eq("pending")

      # Force stripe api to return succeeded
      payment_intent_response = { "id" => payment.stripe_payment_inent_id, "status" => "succeeded" }
      allow(payment.stripe_client).to receive(:find_intent).with(payment.stripe_payment_inent_id).and_return(payment_intent_response)

      # Confirm payment
      payment.stripe_confirm_payment

      # Payment status is now paid
      get "/payments/#{payment.id}/complete"

      expect(payment.reload.status).to eq("paid")
    end

    it "Make payment (api)" do
      payment = create(:payment_1)
      payment.stripe_init_intent

      # Status is pending before payment
      get "/payments/#{payment.id}/complete.json"

      expect(response).to have_http_status(200)
      expect(json["status"]).to eq("pending")

      # Force stripe api to return succeeded
      payment_intent_response = { "id" => payment.stripe_payment_inent_id, "status" => "succeeded" }
      allow(payment.stripe_client).to receive(:find_intent).with(payment.stripe_payment_inent_id).and_return(payment_intent_response)

      # Confirm payment
      payment.stripe_confirm_payment

      # Payment status is now paid
      get "/payments/#{payment.id}/complete.json"

      expect(payment.reload.status).to eq("paid")
    end
  end
end
