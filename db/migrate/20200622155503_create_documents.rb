class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.references  :admin_user
      t.references  :case
      t.string  :file_name
      t.text  :description
      t.date  :date
      t.string  :author

      t.timestamps
    end
  end
end
