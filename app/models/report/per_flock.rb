module Report
  module PerFlock
    extend ActiveSupport::Concern

    module ClassMethods
      def flock_association association = nil
        @flock_association = association if association
        @flock_association
      end

      def data_field field = nil
        @data_field = field if field
        @data_field
      end
    end

    protected

    def first_week
      flocks.map { |flock| flock.first_week }.compact.min
    end

    def column_names
      flocks.map &:to_s
    end

    def row week
      flocks.map { |flock| flock.data_point(week) }
    end

    def flocks
      @flocks ||= user.flocks.map { |flock| adapt(flock) }
    end

    def adapt flock
      ReportableFlock.new(flock, self.class.flock_association, self.class.data_field)
    end

    class ReportableFlock
      def initialize flock, association, field
        @flock, @association, @field = flock, association, field
      end

      def to_s
        flock.name
      end

      def first_week
        @first_week ||=
          data_points.minimum(:occurred_on).try(:beginning_of_week, week_start_day)
      end

      def data_point week_start
        all_weeks[week_start]
      end

      private

      attr_reader :flock, :association, :field

      def data_points
        flock.send(association)
      end

      # Returns a Hash-like object that maps weeks to a total amount of feed
      #
      # My SQL skills aren't quite up to the task of generating this all
      # in one sum-tastic query.
      def all_weeks
        @all_weeks ||=
          data_points.each_with_object(Hash.new(0)) { |feed, all_weeks|
            all_weeks[feed.occurred_on.beginning_of_week(week_start_day)] += feed.send(field)
          }
      end

      def week_start_day
        :sunday
      end
    end
  end
end
