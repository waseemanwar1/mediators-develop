class TranslatePermissions < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        Permission.create_translation_table!({
          :name => :string,
          :description => :string
        }, {
          :migrate_data => false
        })
      end

      dir.down do
        Permission.drop_translation_table! :migrate_data => false
      end
    end
  end
end
