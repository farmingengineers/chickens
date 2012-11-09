module Report
  class FeedPerWeek
    # D3 graph http://d3js.org/
    class << self
      def human_name
        'Feed per week'
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

    def human_name
      self.class.human_name
    end

    def to_yaml
      rows.to_yaml
    rescue => e
      puts e
      raise
    end

    def rows
      [ [nil] + flocks.map { |flock| flock.to_s } ] +
      weeks.map { |week| [week] + flocks.map { |flock| flock.feed_per_week(week) } }.reverse
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
          flock.feedings.minimum(:occurred_on).try(:beginning_of_week, week_start_day)
      end

      def feed_per_week week_start
        all_weeks[week_start]
      end

      private

      attr_reader :flock

      # Returns a Hash-like object that maps weeks to a total amount of feed
      #
      # My SQL skills aren't quite up to the task of generating this all
      # in one sum-tastic query.
      def all_weeks
        @all_weeks ||=
          flock.feedings.each_with_object(Hash.new(0)) { |feed, all_weeks|
            all_weeks[feed.occurred_on.beginning_of_week(week_start_day)] += feed.pounds
          }
      end

      def week_start_day
        :sunday
      end
    end
  end
end
