class AddAgreementTemplateToAgreements < ActiveRecord::Migration[6.0]
  def change
    add_reference :agreements, :agreement_template, foreign_key: true
  end
end
