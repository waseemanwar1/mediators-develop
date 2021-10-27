class AddStripeClientSecretToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :stripe_client_secret, :string
  end
end
