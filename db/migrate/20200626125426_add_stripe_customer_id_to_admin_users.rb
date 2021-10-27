class AddStripeCustomerIdToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :stripe_customer_id, :string
  end
end
