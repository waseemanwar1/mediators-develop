class AddBillingTypeToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :billing_type, :integer
  end
end
