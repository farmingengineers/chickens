class FlocksController < ApplicationController
  before_filter :authenticate_user!

  expose(:flocks) { current_user.flocks }
  expose(:flock)

  def update
    flock.save!
    redirect_to root_path
  end

  protected

  def record_builder
    FlockBuilder.new current_user
  end
end
