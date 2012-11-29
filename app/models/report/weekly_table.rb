module Report
  module WeeklyTable
    def to_hash
      {
        :column_names => ['week'] + column_names,
        :rows => rows,
      }
    end

    def to_csv
      rows.inject((['week'] + column_names).to_csv) { |csv, row| csv + row.to_csv }
    end

    def to_yaml(*args)
      rows.to_yaml(*args)
    rescue => e
      puts e
      raise
    end

    def types
      %W(graph table)
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

    def column_names
      raise 'implement this'
    end

    def row week
      raise "implement this"
    end
  end
end
