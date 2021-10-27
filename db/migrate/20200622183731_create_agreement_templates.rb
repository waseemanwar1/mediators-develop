class CreateAgreementTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :agreement_templates do |t|
      t.string  :name
      t.text  :content
      t.boolean  :public

      t.timestamps
    end
  end
end
