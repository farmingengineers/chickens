class DataPoint < ActiveRecord::Base
  belongs_to :flock
  belongs_to :entered_by, :class_name => 'User'
  attr_accessible :flock_id, :entered_by, :occurred_on, :quantity
end
