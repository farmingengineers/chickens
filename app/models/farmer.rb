class Farmer < ActiveRecord::Base
  belongs_to :farm
  belongs_to :user
  attr_accessible :farm, :user
end
