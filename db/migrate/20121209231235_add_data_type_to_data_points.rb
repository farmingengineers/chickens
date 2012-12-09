class AddDataTypeToDataPoints < ActiveRecord::Migration
  def change
    add_column :data_points, :data_type_id, :integer
    add_index  :data_points, :data_type_id
  end
end
