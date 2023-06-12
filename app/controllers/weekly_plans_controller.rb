class WeeklyPlansController < ApplicationController
  def index
    @profile = current_user.profile
    @weekly_plans = @profile.weekly_plans.order(created_at: :asc)
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
    @profile = Profile.last

    @weekly_plan = WeeklyPlan.create(profile: @profile)

    diet_client = WeeklyPlanApiClient.new(@profile)

    daily_diet_plans = diet_client.fetch_weekly_plan.values


    daily_diet_plans.each_with_index do |daily_diet_plan, index|
      day_plan = DayPlan.create(day_number: index + 1, weekly_plan: @weekly_plan)

      breakfast = diet_client.fetch_meal(JSON.parse(daily_diet_plan[0]["value"])["id"])
      lunch = diet_client.fetch_meal(JSON.parse(daily_diet_plan[1]["value"])["id"])
      dinner = diet_client.fetch_meal(JSON.parse(daily_diet_plan[2]["value"])["id"])

      DietPlan.create(
        day_plan_content: {
          breakfast: breakfast,
          lunch: lunch,
          dinner: dinner
        },
        day_plan: day_plan
      )
    end
    # if current_user.gender.downcase == "male"
    #   s = 5
    # else
    #   s = -161
    # end
    # current_bmr = (10 * params[:weekly_plan][:current_weight].to_i) + (6.25 * current_user.height) - (5 * user_age) + s
    # activity_factor = 1.55
    # t_d_e_e = current_bmr * activity_factor
    # calories_per_day = [(t_d_e_e - 1000), (t_d_e_e - 500)]
    # puts calories_per_day
    # redirect_to redirect_path
    # CreateWeeklyPlanJob.perform_later(current_user, user_age, current_bmr, calories_per_day, take_params)
  end
end
