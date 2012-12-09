class Bookkeeper
  def initialize flock, user
    @flock = flock
    @user = user
  end

  attr_reader :flock, :user

  StepSizes = { 'daily' => 1, 'weekly' => 7 }

  def build params
    dates = lazy_dates params
    quantities = params[quantity_param].split(/[\s,]+/).select(&:present?)
    quantities.zip(dates).map do |quantity, date|
      data_association.build base_attrs(params).merge :occurred_on => date, :quantity => quantity
    end
  end

  protected

  def lazy_dates params
    start_date = params[:start_on].to_date
    step_size = StepSizes[params[:frequency]]
    LazySequence.new start_date, step_size
  end

  def base_attrs params
    { :entered_by => user }
  end

  class LazySequence
    include Enumerable
    def initialize start, step
      @start = start
      @step = step
    end
    def each
      current = @start
      loop do
        yield current
        current = current + @step
      end
    end
  end
end
