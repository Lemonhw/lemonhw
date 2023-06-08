class WeeklyPlansController < ApplicationController
  before_action :take_params, only: [:create]

  def index
    @weekly_plans = current_user.weekly_plans.order(created_at: :asc)
  end

  def show
    @weekly_plan = WeeklyPlan.find(params[:id])
    # Retrieve diet and exercise plans for the week
    @day_plans = @weekly_plan.day_plans.order(day_number: :asc)
  end

  def new
    @weekly_plan = WeeklyPlan.new
  end

  def create
    CreateWeeklyPlanJob.perform_later(current_user, take_params)
    redirect_to dashboard_path
  end

  private

  def take_params
    params.require(:weekly_plan).permit(:current_weight, :weight_goal, :fitness_goal)
  end
end
