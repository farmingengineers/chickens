require 'csv'

class ReportsController < ApplicationController
  before_filter :authenticate_user!

  expose(:reports) { Report.all }
  expose(:report) { Report.generate params[:id], params.merge(:current_user => current_user) }

  def show
    respond_to do |format|
      format.html
      format.csv { render :text => report.rows.map(&:to_csv).join('') }
    end
  end
end
