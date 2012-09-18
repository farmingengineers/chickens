class HomeController < ApplicationController
  expose(:flocks) { current_user.try(:flocks) }
end
