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

      post "/payments/#{payment.id}/create", params: { id: payment.id, payment: {} }
    end

    it "Make payment (api)" do
      payment = create(:payment_1)
      payment.stripe_init_intent

      post "/payments/#{payment.id}/create.json", params: { id: payment.id, payment: {} }

      expect(response).to have_http_status(200)
    end
  end
end
