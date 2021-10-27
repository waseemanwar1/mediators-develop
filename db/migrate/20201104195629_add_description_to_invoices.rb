class AddDescriptionToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :description, :text
  end
end
