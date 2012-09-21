class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.belongs_to :flock
      t.belongs_to :entered_by
      t.date :occurred_on
      t.float :quantity

      t.timestamps
    end
    add_index :data_points, :flock_id
    add_index :data_points, :entered_by_id
  end
end
