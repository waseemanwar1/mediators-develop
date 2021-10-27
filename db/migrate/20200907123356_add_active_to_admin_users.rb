class AddActiveToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :active, :boolean, default: true
  end
end
