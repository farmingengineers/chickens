class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  expose(:flocks) { current_user.flocks }
  expose(:flock)
  expose(:activities) { flock.data_points }

  def destroy
    activities.where(:id => params[:id]).delete_all
    redirect_to :back
  end
end
