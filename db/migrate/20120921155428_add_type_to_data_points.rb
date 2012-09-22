class AddTypeToDataPoints < ActiveRecord::Migration
  def change
    add_column :data_points, :type, :string
  end
end
