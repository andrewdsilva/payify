require "rails_helper"

RSpec.describe ::Payify::Payment, type: :model do
  describe "Add payment on a model" do
    let!(:reservation) { create(:reservation_1) }

    it "Create payment for reservation" do
      reservation.create_payment

      expect(reservation.payment).not_to eq(nil)
    end
  end
end
