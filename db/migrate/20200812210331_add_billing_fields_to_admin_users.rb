class AddBillingFieldsToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :billing_address_line_1, :string
    add_column :admin_users, :billing_address_line_2, :string
    add_column :admin_users, :billing_postcode, :string
    add_column :admin_users, :billing_city, :string
    add_column :admin_users, :billing_state, :string
    add_column :admin_users, :billing_country, :string
  end
end
