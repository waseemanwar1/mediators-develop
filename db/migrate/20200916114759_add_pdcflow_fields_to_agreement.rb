class AddPdcflowFieldsToAgreement < ActiveRecord::Migration[6.0]
  def change
    add_column :agreements, :pdcflow_document_id, :string
    add_column :agreements, :pdcflow_signature_id, :string
    add_column :agreements, :pdcflow_signature_link, :text
    add_column :agreements, :pdcflow_verification_pin, :string
  end
end
