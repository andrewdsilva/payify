require "rails_helper"

RSpec.describe ::Payify::Payment, type: :model do
  subject { create(:payment_1) }

  let(:freeze_time) { Time.utc(2023, 6, 14, 6, 54, 0) }

  it "Has amount and statuses" do
    expect(subject.amount).to eq(1500)
    expect(subject.status).to eq("pending")
    expect(subject.payment_method).to eq("stripe")
    expect(subject.transaction_id).to be_nil
  end

  it "Is not paid by default" do
    expect(subject).not_to be_paid
  end

  it "Can set payment and mark as paid" do
    Timecop.freeze(freeze_time) do
      subject.make_payment("transaction_123")
    end

    expect(subject).to be_paid
    expect(subject.status).to eq("paid")
    expect(subject.transaction_id).to eq("transaction_123")
    expect(subject.paid_at.to_time.utc).to eq(freeze_time)
  end

  it "Cannot be destroyed if paid" do
    subject.make_payment("transaction_123")
    expect(subject.can_destroy?).to be_falsey
    expect { subject.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
    expect(::Payify::Payment.exists?(subject.id)).to be_truthy
  end

  it "Can be destroyed if not paid" do
    expect(subject.can_destroy?).to be_truthy
    expect { subject.destroy }.to change(::Payify::Payment, :count).by(-1)
  end
end
