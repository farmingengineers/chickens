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
      enum_for :each_week
    end

    def weeks
      if earliest = flocks.map { |flock| flock.earliest_date }.compact.min
        earliest.beginning_of_week(:sunday).step(Date.today, 7)
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

      def earliest_date
        flock.egg_collections.minimum(:occurred_on).tap { |x| Rails.logger.debug "#{flock.inspect} -- #{x}" }
      end

      def eggs_per_week week_start
        flock.egg_collections.where('occurred_on BETWEEN ? AND ?', week_start, week_start + 6).sum(:quantity)
      end

      private

      attr_reader :flock
    end
  end
end
