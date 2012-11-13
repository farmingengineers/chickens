class EggCollectionsController < ApplicationController
  before_filter :authenticate_user!
  expose(:flocks) { current_user.flocks }
  expose(:flock)

  def destroy
    flock.egg_collections.find(params[:id]).destroy
    if request.xhr?
      head :ok
    else
      redirect_to :back
    end
  end

  protected
  def record_builder
    EggCollector.new flock, current_user
  end
end
