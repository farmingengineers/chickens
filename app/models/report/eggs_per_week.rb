module Report
  class EggsPerWeek
    include Base
    include WeeklyTable
    include PerFlock

    human_name 'Eggs per week'
    flock_association :egg_collections
    data_field :eggs
  end
end
