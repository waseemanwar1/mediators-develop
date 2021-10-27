class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references  :admin_user
      t.references  :case
      t.references  :party
      t.string  :name
      t.integer  :time
      t.integer  :amount
      t.date  :date
      t.date  :due_date
      t.integer  :status

      t.timestamps
    end
  end
end
