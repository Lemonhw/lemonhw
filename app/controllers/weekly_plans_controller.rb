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
    time = Benchmark.measure do
      api_client = WeeklyPlanApiClient.new
      birth_date = current_user.date_of_birth
      current_date = Date.today
      user_age = current_date.year - birth_date.year
      user_age -= 1 if current_date.month < birth_date.month || (current_date.month == birth_date.month && current_date.day < birth_date.day)
      user_info = {
        age: user_age,
        gender: current_user.gender,
        height: current_user.height
      }

      @weekly_plan = WeeklyPlan.create!(take_params.merge(user: current_user))

      plans_json = api_client.fetch_plans(user_info, take_params)
      week_diet_plan = JSON.parse(plans_json[:diet_plan])
      week_exercise_plan = JSON.parse(plans_json[:exercise_plan])
      diet_plans = week_diet_plan.values
      exercise_plans = week_exercise_plan.values

      (0...6).to_a.each do |index|
        @day_plan = DayPlan.create!(
          day_number: index + 1,
          weekly_plan: @weekly_plan
        )
        DietPlan.create!(
          day_plan_content: diet_plans[index],
          day_plan: @day_plan
        )
        ExercisePlan.create!(
          day_plan_content: exercise_plans[index],
          day_plan: @day_plan
        )
      end
    end
    puts "Execution time: #{time.real} seconds"
    redirect_to dashboard_path
  end

  private

  def take_params
    params.require(:weekly_plan).permit(:current_weight, :weight_goal, :fitness_goal)
  end
end
