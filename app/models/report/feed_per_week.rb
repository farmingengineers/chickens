module Report
  class FeedPerWeek
    include Base
    include WeeklyTable
    include PerFlock

    human_name 'Feed per week'
    flock_association :feedings
    data_field :pounds
  end
end
