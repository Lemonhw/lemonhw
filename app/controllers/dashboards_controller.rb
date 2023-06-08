class DashboardsController < ApplicationController
  def show
    @weekly_plans = current_user.weekly_plans.order(created_at: :desc)
    # @first_day_exercise_plan = @weekly_plans.first.day_plans.first.exercise_plan
  end
end
