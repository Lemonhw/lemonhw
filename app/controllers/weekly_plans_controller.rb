class WeeklyPlansController < ApplicationController
  before_action :take_params, only: [:create]

  def index
    @weekly_plans = current_user.weekly_plans.order(created_at: :asc)
  end

  def show
    @weekly_plan = WeeklyPlan.find(params[:id])
    # Retrieve diet and exercise plans for the week
    @day_plans = @weekly_plan.day_plans.order(day_number: :asc)

    if request.xhr?
      render layout: false
    end
  end

  def new
    @weekly_plan = WeeklyPlan.new
  end

  def create
    birth_date = current_user.date_of_birth
    current_date = Date.today
    user_age = current_date.year - birth_date.year
    user_age -= 1 if current_date.month < birth_date.month || (current_date.month == birth_date.month && current_date.day < birth_date.day)

    if current_user.gender.downcase == "male"
      s = 5
    else
      s = -161
    end
    current_bmr = (10 * params[:weekly_plan][:current_weight].to_i) + (6.25 * current_user.height) - (5 * user_age) + s
    activity_factor = 1.55
    t_d_e_e = current_bmr * activity_factor
    calories_per_day = [(t_d_e_e - 1000), (t_d_e_e - 500)]
    puts calories_per_day
    redirect_to redirect_path
    CreateWeeklyPlanJob.perform_later(current_user, user_age, current_bmr, calories_per_day, take_params)
  end

  private

  def take_params
    params.require(:weekly_plan).permit(:current_weight, :weight_goal, :fitness_goal)
  end
end
