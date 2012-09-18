class CreateFarmers < ActiveRecord::Migration
  def change
    create_table :farmers do |t|
      t.belongs_to :farm
      t.belongs_to :user

      t.timestamps
    end
    add_index :farmers, :farm_id
    add_index :farmers, :user_id
  end
end
