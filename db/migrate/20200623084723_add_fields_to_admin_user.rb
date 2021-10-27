class AddFieldsToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :hourly_rate, :integer
    add_column :admin_users, :company_name, :string
    add_column :admin_users, :phone, :string
    add_column :admin_users, :company_website, :string
    add_column :admin_users, :address_line_1, :string
    add_column :admin_users, :address_line_2, :string
    add_column :admin_users, :postcode, :string
    add_column :admin_users, :city, :string
    add_column :admin_users, :state, :string
    add_column :admin_users, :country, :string
  end
end
