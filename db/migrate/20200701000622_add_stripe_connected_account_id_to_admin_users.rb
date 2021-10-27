class AddStripeConnectedAccountIdToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :stripe_connected_account_id, :string
  end
end
