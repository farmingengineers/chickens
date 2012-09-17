class Farmer < ActiveRecord::Base
  belongs_to :farm
  belongs_to :user
end
