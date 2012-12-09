class DataPoint < ActiveRecord::Base
  belongs_to :flock
  belongs_to :entered_by, :class_name => 'User'
  belongs_to :data_type
  attr_accessible :flock_id, :data_type_id, :entered_by, :occurred_on, :quantity
end
