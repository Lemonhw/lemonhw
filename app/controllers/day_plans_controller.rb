class DayPlansController < ApplicationController
  def show
    @day_plan = DayPlan.find(params[:id])
    @weekly_plan = @day_plan.weekly_plan
    @diet_plan = @day_plan.diet_plan
    @exercise_plan = @day_plan.exercise_plan
  end
end
