class AdminUsersGrouops < ActiveRecord::Migration[6.0]
  def change
    create_join_table :admin_users, :groups do |t|
      t.index [:admin_user_id, :group_id]
      t.index [:group_id, :admin_user_id]
    end
  end
end
