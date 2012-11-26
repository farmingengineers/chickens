module Report
  class TotalConversion
    include Base
    include WeeklyTable
    include ConversionCalculator

    human_name 'Aggregate Feed conversion (doz eggs / 50 lb)'

    def first_week
      [feedings, eggs].flatten.map(&:first_week).compact.min
    end

    def column_names
      ['doz eggs / 50 lb']
    end

    def row week
      e = aggregate eggs, week
      f = aggregate feedings, week
      [ conversion(:eggs => e, :feed => f) ]
    end

    private

    def aggregate reportable, week
      reportable.map { |r| r.data_point(week) }.compact.inject(&:+)
    end

    def feedings
      @feedings ||= flocks.map { |flock| Report::PerFlock::ReportableFlock.new(flock, :feedings, :pounds) }
    end

    def eggs
      @eggs ||= flocks.map { |flock| Report::PerFlock::ReportableFlock.new(flock, :egg_collections, :eggs) }
    end

    def flocks
      user.flocks
    end
  end
end
