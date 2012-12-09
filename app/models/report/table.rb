module Report
  module Table
    def types
      super + ['table']
    end

    def to_hash
      { :column_names => column_names, :rows => rows }
    end

    def to_csv
      rows.inject((column_names).to_csv) { |csv, row| csv + row.to_csv }
    end

    def column_names
      [category_column_name] + data_column_names
    end
  end
end
