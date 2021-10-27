class AddSubscriptionPaidToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :subscription_paid, :boolean, default: false
    add_column :admin_users, :stripe_product_id, :string
    add_column :admin_users, :stripe_subscription_id, :string
  end
end
