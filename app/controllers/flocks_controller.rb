class FlocksController < ApplicationController
  before_filter :authenticate_user!

  expose(:flocks) { current_user.flocks }
  expose(:flock)
  expose(:recent_activity) { flock.recent_activity }

  def update
    # TODO -- scrub the incoming parameters!
    flock.save!
    redirect_to root_path
  end

  protected

  def record_builder
    FlockBuilder.new current_user
  end
end
