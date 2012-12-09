module Report
  module WeeklyTable
    include Table

    def types
      super + ['graph']
    end

    def category_column_name
      'week'
    end

    def rows
      weeks.map { |week| [week] + row(week) }.reverse
    end

    protected

    def weeks
      if earliest = first_week
        earliest.step(Date.today, 7)
      else
        []
      end
    end

    def first_week
      raise 'implement this'
    end

    def row week
      raise "implement this"
    end
  end
end
