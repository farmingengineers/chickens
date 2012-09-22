class Flock < ActiveRecord::Base
  belongs_to :farm
  has_many :data_points
  has_many :feedings
  has_many :egg_collections
  attr_accessible :farm, :name

  scope :summary, joins('LEFT OUTER JOIN data_points ON data_points.flock_id = flocks.id').select('flocks.id, flocks.name, max(data_points.occurred_on) as most_recent_activity_on').group('flocks.id, flocks.name').order('flocks.name')

  def to_s
    name
  end

  def recent_activity
    data_points.order('occurred_on desc')
  end

  def most_recent_activity_on
    self[:most_recent_activity_on].try :to_date
  end
end