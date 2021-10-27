class CreateJoinTableContactParty < ActiveRecord::Migration[6.0]
  def change
    create_join_table :contacts, :parties do |t|
      # t.index [:contact_id, :party_id]
      # t.index [:party_id, :contact_id]
    end
  end
end
