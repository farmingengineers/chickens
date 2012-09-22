class EggCollectionsController < ApplicationController
  before_filter :authenticate_user!
  expose(:flocks) { current_user.flocks }
  expose(:flock)

  protected
  def record_builder
    EggCollector.new flock, current_user
  end
end
