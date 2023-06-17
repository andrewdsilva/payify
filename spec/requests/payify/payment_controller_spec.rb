require "rails_helper"

RSpec.describe "Payify::PaymentControllers", type: :request do
  describe "GET #new" do
    it "New payment form" do
      payment = create(:payment_1)

      get "/payments/#{payment.id}/new", params: { id: payment.id }

      expect(response).to render_template("new.html.erb")
    end

    it "New payment (api)" do
      payment = create(:payment_1)

      get "/payments/#{payment.id}/new", params: { id: payment.id }, format: :json

      expect(response.content_type).to eq("application/json")
    end
  end

  describe "Make payment" do
    it "calls pay_with_stripe on the payment" do
      payment = create(:payment_1)
      payment.stripe_init_intent

      post "/payments/#{payment.id}", params: { id: payment.id, payment: {} }
    end

    it "Make payment (api)" do
      payment = create(:payment_1)
      payment.stripe_init_intent

      post "/payments/#{payment.id}", params: { id: payment.id, payment: {} }, format: :json

      expect(response.content_type).to eq("application/json")
    end
  end
end
