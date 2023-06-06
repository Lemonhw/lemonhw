class DayPlansController < ApplicationController
  def show
    @day_plan = DayPlan.find(params[:id])
  end
end
