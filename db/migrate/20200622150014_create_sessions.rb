class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.references  :admin_user
      t.references  :case
      t.references  :party
      t.string  :name
      t.date  :due_date
      t.time  :time_start
      t.time  :time_finish
      t.integer  :session_type
      t.string  :location
      t.text  :tags, array: true, default: []
      t.integer  :rate_type
      t.integer  :rate

      t.timestamps
    end
  end
end
