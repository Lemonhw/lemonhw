class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def overview
    @profile = current_user.profile
    @weekly_plans = @profile.weekly_plans.order(created_at: :desc)
  end

  def show
    @profile = current_user.profile
    @weekly_plans = @profile.weekly_plans.order(created_at: :desc)

    if @weekly_plans.any?
      @weekly_plan = @weekly_plans.first
      @day_plans = @weekly_plan.day_plans.order(created_at: :asc)
    end
  end


  def exercise_plan
    @profile = current_user.profile
    @weekly_plans = @profile.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      @weekly_plan = @weekly_plans.first
      @day_plans = @weekly_plan.day_plans.order(created_at: :asc)
    end
  end

  def diet_plan
    @profile = current_user.profile
    @weekly_plans = @profile.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      @weekly_plan = @weekly_plans.first
      @day_plans = @weekly_plan.day_plans.order(created_at: :asc)
    end
  end
end
