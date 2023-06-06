require_relative "../services/weekly_plan_api_client"

class WeeklyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]
  before_action :take_params, only: [:create]

  def index
  end

  def show
  end

  def new
    @weekly_plan = WeeklyPlan.new
  end

  def create
    api_client = WeeklyPlanAPIClient.new
    user_info = {
      age: current_user.age,
      gender: current_user.gender,
      height: current_user.height
    }

    plans = api_client.fetch_plans(user_info, take_params)

    @weekly_plan = WeeklyPlan.new(
      current_weight: take_params[:current_weight],
      weight_goal: take_params[:weight_goal],
      fitness_goal: take_params[:fitness_goal],
      weekly_diet_plan: plans[:diet_plan],
      weekly_exercise_plan: plans[:exercise_plan],
      user_id: current_user.id
    )
  end

  private

  def take_params
    params.require(:weekly_plan).permit(:current_weight, :weight_goal, :fitness_goal)
  end
end
