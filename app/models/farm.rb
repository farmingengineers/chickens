class Farm < ActiveRecord::Base
  has_many :farmers
  has_many :users, :through => :farmers
  has_many :flocks
  has_many :feed_types
end
