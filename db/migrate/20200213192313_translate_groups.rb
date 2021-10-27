class TranslateGroups < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        Group.create_translation_table!({
          :name => :string
        }, {
          :migrate_data => false
        })
      end

      dir.down do
        Group.drop_translation_table! :migrate_data => false
      end
    end
  end
end
