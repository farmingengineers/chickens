class Bookkeeper
  def initialize flock, user
    @flock = flock
    @user = user
  end

  attr_reader :flock, :user

  StepSizes = { 'daily' => 1, 'weekly' => 7 }

  def build params
    points = (params[:points] || {}).values.select { |point| point[:date].present? && point[:quantity].present? }
    points.map { |point| data_association.build base_attrs(params).merge :occurred_on => point[:date], :quantity => point[:quantity] }
  end

  protected

  def base_attrs params
    { :entered_by => user }
  end
end
