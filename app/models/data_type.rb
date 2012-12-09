class DataType < ActiveRecord::Base
  belongs_to :farm
  attr_accessible :farm, :name, :description

  def to_s
    name
  end
end
