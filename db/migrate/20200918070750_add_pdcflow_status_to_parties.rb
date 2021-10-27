class AddPdcflowStatusToParties < ActiveRecord::Migration[6.0]
  def change
    add_column :parties, :pdcflow_status, :string
  end
end
