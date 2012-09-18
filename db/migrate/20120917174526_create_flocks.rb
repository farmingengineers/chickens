class CreateFlocks < ActiveRecord::Migration
  def change
    create_table :flocks do |t|
      t.string :name
      t.belongs_to :farm

      t.timestamps
    end
  end
end
