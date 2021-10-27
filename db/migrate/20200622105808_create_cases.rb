class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.references  :admin_user
      t.string  :program
      t.string  :name
      t.text  :description
      t.text  :tags, array: true, default: []
      t.integer  :status

      t.timestamps
    end
  end
end
