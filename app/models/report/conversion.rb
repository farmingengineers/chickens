module Report
  class Conversion
    include Base
    include WeeklyTable
    include PerFlock

    human_name 'Feed conversion (doz eggs / 50 lb)'

    def adapt flock
      FlockConversion.new(flock)
    end

    class FlockConversion
      def initialize flock
        @flock = flock
      end

      def to_s
        flock.name
      end

      def first_week
        [eggs, feedings].map(&:first_week).compact.min
      end

      def data_point week
        e = eggs.data_point week
        f = feedings.data_point week
        if e > 0
          if f > 0
            (e / 12.0) / (f / 50.0)
          else
            'inf'
          end
        else
          if f > 0
            0
          else
            nil
          end
        end
      end

      private

      attr_reader :flock

      def eggs
        @eggs ||= Report::PerFlock::ReportableFlock.new(flock, :egg_collections, :eggs)
      end

      def feedings
        @feedings ||= Report::PerFlock::ReportableFlock.new(flock, :feedings, :pounds)
      end
    end
  end
end
