class AddStripePaymentIntentId < ActiveRecord::Migration[7.0]
  def change
    add_column :payify_payments, :stripe_payment_inent_id, :integer
  end
end
