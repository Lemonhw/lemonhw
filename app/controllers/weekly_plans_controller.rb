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

    muscles = {
      "1" => ["chest", "triceps", "traps"],
      "3" => ["hamstrings", "quadriceps", "quadriceps"],
      "4" => ["lats", "biceps", "lower_back"],
      "6" => ["abdominals", "calves", "abdominals"]
    }

    @profile = Profile.last

    @weekly_plan = WeeklyPlan.create(profile: @profile)

    diet_client = WeeklyPlanApiClient.new(@profile)

    daily_diet_plans = diet_client.fetch_weekly_plan.values


    daily_diet_plans.each.with_index(1) do |daily_diet_plan, index|
      day_plan = DayPlan.create(day_number: index, weekly_plan: @weekly_plan)

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

      difficulty = @profile.workout_difficulty.downcase

      muscles_index = index.to_s

      if day_plan.day_number == 2 || day_plan.day_number == 5 || day_plan.day_number == 7
        ExercisePlan.create(
          day_plan_content: "rest",
          day_plan: day_plan
        )
      else
        exercise1 = Exercise.where(difficulty: difficulty, muscle: muscles[muscles_index][0]).to_a.sample
        exercise2 = Exercise.where(difficulty: difficulty, muscle: muscles[muscles_index][1]).to_a.sample
        exercise3 = Exercise.where(difficulty: difficulty, muscle: muscles[muscles_index][2]).to_a.sample
        exercise4 = Exercise.where(difficulty: difficulty, muscle: muscles[muscles_index][0]).to_a.sample
        exercise5 = Exercise.where(difficulty: difficulty, muscle: muscles[muscles_index][1]).to_a.sample
        ExercisePlan.create(
          day_plan_content: {
            exercise1: exercise1,
            exercise2: exercise2,
            exercise3: exercise3,
            exercise4: exercise4,
            exercise5: exercise5
          },
          day_plan: day_plan
        )
      end
      flash[:notice] = 'Your plans have been generated successfully! Check out the Diet Plan and Exercise Plan tabs to see your plans'
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
