class CreateAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :agreements do |t|
      t.references  :admin_user
      t.references  :case
      t.string  :name
      t.text  :content

      t.timestamps
    end
  end
end
