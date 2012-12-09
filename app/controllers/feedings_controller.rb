class FeedingsController < ApplicationController
  before_filter :authenticate_user!
  expose(:flocks) { current_user.flocks }
  expose(:flock)
  expose(:feed_types) { flock.farm.feed_types }

  def destroy
    flock.feedings.find(params[:id]).destroy
    if request.xhr?
      head :ok
    else
      redirect_to :back
    end
  end

  protected
  def record_builder
    Feeder.new flock, current_user
  end
end
