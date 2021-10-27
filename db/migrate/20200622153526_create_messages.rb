class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references  :admin_user
      t.references  :case
      t.references  :party
      t.string  :subject
      t.date  :sent_at
      t.text  :content
      t.string  :from
      t.string  :to

      t.timestamps
    end
  end
end
