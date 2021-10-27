class AddPdcflowFieldsToParties < ActiveRecord::Migration[6.0]
  def change
    add_column :parties, :pdcflow_signature_id, :string
    add_column :parties, :pdcflow_signature_link, :text
    add_column :parties, :pdcflow_verification_pin, :string
  end
end
