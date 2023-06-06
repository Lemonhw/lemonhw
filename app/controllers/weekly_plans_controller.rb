require_relative "../services/weekly_plan_api_client"
require 'benchmark'

class WeeklyPlansController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:new]
  before_action :take_params, only: [:create]

  def index
  end

  def show
    @weekly_plan = WeeklyPlan.find(params[:id])
  end

  def new
    @weekly_plan = WeeklyPlan.new
  end

  def create
    time = Benchmark.measure do
      api_client = WeeklyPlanAPIClient.new
      user_info = {
        age: 65, # change this to curernt_user.age
        gender: "male", # chane this to current_user.gender
        height: 150 # change this to current_user.height
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
    puts "Execution time: #{time.real} seconds"
    redirect_to weekly_plan_path(@weekly_plan) if @weekly_plan.save

  end

  private

  def take_params
    params.require(:weekly_plan).permit(:current_weight, :weight_goal, :fitness_goal)
  end
end
