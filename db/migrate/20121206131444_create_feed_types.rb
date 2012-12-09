class CreateFeedTypes < ActiveRecord::Migration
  def change
    create_table :feed_types do |t|
      t.belongs_to :farm
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :feed_types, :farm_id
  end
end
