class RenameFeedTypesToDataTypes < ActiveRecord::Migration
  def up
    rename_table :feed_types, :data_types
    add_column :data_types, :type, :string
    execute "UPDATE data_types SET type = 'FeedType'"
  end

  def down
    remove_column :data_types, :type, :string
    rename_table :data_types, :feed_types
  end
end
