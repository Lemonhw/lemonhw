class DashboardsController < ApplicationController
  def show
    @profile = current_user.profile
    @weekly_plans = @profile.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      first_weekly_plan = @weekly_plans.first
      @first_day_exercise_plan = first_weekly_plan.day_plans.first&.exercise_plan
      @first_day_diet_plan = first_weekly_plan.day_plans.first&.diet_plan
      @video = Video.find_by(title: "Half An Hour Weight Loss - 30 Min Home Workout To Burn Fat")
    end
  end
end
