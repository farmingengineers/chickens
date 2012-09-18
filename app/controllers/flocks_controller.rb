class FlocksController < ApplicationController
  before_filter :authenticate_user!

  expose(:flock)

  protected

  def record_builder
    FlockBuilder.new current_user
  end
end
