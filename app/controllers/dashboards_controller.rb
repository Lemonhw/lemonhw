class DashboardsController < ApplicationController
  def show
    @weekly_plans = current_user.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      first_weekly_plan = @weekly_plans.first
      @first_day_exercise_plan = first_weekly_plan.day_plans.first&.exercise_plan
      @first_day_diet_plan = first_weekly_plan.day_plans.first&.diet_plan
    end
  end
end
