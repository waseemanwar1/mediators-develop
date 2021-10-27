class AddKeyToPermissions < ActiveRecord::Migration[6.0]
  def change
    add_column :permissions, :key, :string
  end
end
