class HomeController < ApplicationController
  expose(:flocks) { current_user && current_user.flocks.summary }
end
