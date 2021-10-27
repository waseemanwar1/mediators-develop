class CreateJoinTableContactCase < ActiveRecord::Migration[6.0]
  def change
    create_join_table :contacts, :cases do |t|
      # t.index [:contact_id, :case_id]
      # t.index [:case_id, :contact_id]
    end
  end
end
