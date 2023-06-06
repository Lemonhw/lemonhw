class DashboardsController < ApplicationController
  def show
    # Fetch user-specific data or perform any necessary logic here
    @user = current_user
    @plans = @user.weekly_plans

    # Render the dashboard view
  end
end
