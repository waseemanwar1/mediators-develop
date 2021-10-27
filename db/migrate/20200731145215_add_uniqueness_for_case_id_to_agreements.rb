class AddUniquenessForCaseIdToAgreements < ActiveRecord::Migration[6.0]
  def change
    remove_reference :agreements, :case
    add_reference :agreements, :case, index: {:unique=>true}
  end
end
