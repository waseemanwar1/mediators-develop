class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.references  :admin_user
      t.references  :case
      t.references  :party
      t.string  :title
      t.text  :description
      t.string  :resolution_title
      t.text  :resolution_description
      t.string  :mediators_notes_title
      t.text  :mediators_notes_description
      t.text  :agreement

      t.timestamps
    end
  end
end
