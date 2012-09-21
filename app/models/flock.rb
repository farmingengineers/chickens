class Flock < ActiveRecord::Base
  belongs_to :farm
  has_many :feedings
  has_many :collections
  attr_accessible :farm, :name

  def to_s
    name
  end
end
