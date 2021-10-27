class AddStripePaymentIntentIdToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :stripe_payment_intent_id, :string
  end
end
