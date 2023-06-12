class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def overview
    @weekly_plans = current_user.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      @weekly_plan = @weekly_plans.first
    end
  end

  def exercise_plan
    @weekly_plans = current_user.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      @weekly_plan = @weekly_plans.first
      @day_plans = @weekly_plan.day_plans.order(created_at: :asc)
    end
  end

  def diet_plan
    @weekly_plans = current_user.weekly_plans.order(created_at: :desc)
    if @weekly_plans.any?
      @weekly_plan = @weekly_plans.first
      @day_plans = @weekly_plan.day_plans.order(created_at: :asc)
    end
  end
end
