class CollectionsController < ApplicationController
  before_filter :authenticate_user!
  expose(:flocks) { current_user.flocks }
  expose(:flock)
end
