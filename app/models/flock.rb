class Flock < ActiveRecord::Base
  belongs_to :farm
  has_many :data_points
  has_many :feedings
  has_many :collections
  attr_accessible :farm, :name

  def to_s
    name
  end

  def recent_activity
    data_points.order('occurred_on desc')
  end
end
