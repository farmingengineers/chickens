module Report
  class << self
    def all
      [
        Report::EggsPerWeek,
        Report::FeedPerWeek,
        Report::Conversion,
      ]
    end

    def generate report_id, params
      all.find { |report_class| report_class.id == report_id }.generate(params)
    end
  end
end
