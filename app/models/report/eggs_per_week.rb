module Report
  class EggsPerWeek
    class << self
      def human_name
        'Eggs per week'
      end

      def id
        self.name.demodulize.underscore
      end

      def generate params
        new params
      end
    end

    def initialize params
      @params = params
    end

    def to_yaml
      rows.to_yaml
    rescue => e
      puts e
      raise
    end

    def rows
      [ [nil] + flocks.map { |flock| flock.to_s } ] +
      weeks.map { |week| [week] + flocks.map { |flock| flock.eggs_per_week(week) } }
    end

    private

    attr_reader :params

    def user
      params[:current_user]
    end

    def weeks
      if earliest = flocks.map { |flock| flock.first_week }.compact.min
        earliest.step(Date.today, 7)
      else
        []
      end
    end

    def flocks
      @flocks ||= user.flocks.map { |flock| ReportableFlock.new(flock) }
    end

    class ReportableFlock
      def initialize flock
        @flock = flock
      end

      def to_s
        flock.name
      end

      def first_week
        @first_week ||=
          flock.egg_collections.minimum(:occurred_on).try(:beginning_of_week, week_start_day)
      end

      def eggs_per_week week_start
        all_weeks[week_start]
      end

      private

      attr_reader :flock

      # Returns a Hash-like object that maps weeks to a count of eggs
      #
      # My SQL skills aren't quite up to the task of generating this all
      # in one sum-tastic query.
      def all_weeks
        @all_weeks ||=
          flock.egg_collections.each_with_object(Hash.new(0)) { |eggs, all_weeks|
            all_weeks[eggs.occurred_on.beginning_of_week(week_start_day)] += eggs.quantity.to_i
          }
      end

      def week_start_day
        :sunday
      end
    end
  end
end
