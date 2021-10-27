class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.references  :admin_user
      t.references  :case
      t.references  :party
      t.string  :name
      t.text  :description
      t.integer  :priority
      t.date  :due_date
      t.references  :contact
      t.integer  :status

      t.timestamps
    end
  end
end
