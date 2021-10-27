class CreateParties < ActiveRecord::Migration[6.0]
  def change
    create_table :parties do |t|
      t.references  :admin_user
      t.references  :case
      t.string  :first_name
      t.string  :last_name
      t.string  :title
      t.string  :company
      t.string  :address
      t.text  :notes
      t.string  :email
      t.string  :phone
      t.string  :street
      t.string  :city
      t.string  :state
      t.string  :zip_code
      t.string  :country
      t.text  :tags, array: true, default: []

      t.timestamps
    end
  end
end
