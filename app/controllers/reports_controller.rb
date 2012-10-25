class ReportsController < ApplicationController
  before_filter :authenticate_user!

  expose(:reports) { Report.all }
  expose(:report) { Report.generate params[:id], params.merge(:current_user => current_user) }
end
