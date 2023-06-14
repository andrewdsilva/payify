require "rails_helper"

RSpec.describe Payify::HasPaymentConcern do
  let(:reservation) { create(:reservation_1) }
  subject { reservation }

  describe "Add payment to a model" do
    it "Build a payment" do
      expect(subject.payment).to eq(nil)
      expect(subject.create_payment).to be_a(Payify::Payment)
      expect(subject.payment).to be_a(Payify::Payment)
    end
  end

  describe "Cancel payment" do
    context "When payment is present" do
      let!(:payment) { subject.create_payment }

      it "Destroys the payment" do
        subject.cancel_payment
        expect(Payify::Payment.exists?(payment.id)).to be_falsey
      end
    end

    context "When payment is not present" do
      it "Does not raise an error" do
        expect { subject.cancel_payment }.not_to raise_error
      end
    end
  end

  describe "Default tax rates id" do
    it "Returns nil" do
      expect(subject.tax_rates_id).to be_nil
    end
  end
end
