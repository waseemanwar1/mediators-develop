class RemoveCaseAndPartyFromContacts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :contacts, :case
    remove_reference :contacts, :party
  end
end
