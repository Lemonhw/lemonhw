class DayPlansController < ApplicationController
  def show
    @day_plan = DayPlan.find(params[:id])
    @weekly_plan = @day_plan.weekly_plan
    @diet_plans = @weekly_plan.diet_plans
    @exercise_plans = @weekly_plan.exercise_plans
  end
end
