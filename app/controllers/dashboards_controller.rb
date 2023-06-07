class DashboardsController < ApplicationController
  def show
    @weekly_plans = current_user.weekly_plans.order(created_at: :desc)
  end
end
