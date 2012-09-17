class Flock < ActiveRecord::Base
  belongs_to :farm
  has_many :feedings
  has_many :collections
end
