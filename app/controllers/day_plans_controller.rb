class DayPlansController < ApplicationController
  def show
    @day_plan = DayPlan.find(params[:id])
    @diet_plan = @day_plan.diet_plan
    @diet_plan_content = @diet_plan.day_plan_content
    # @exercise_plan = @day_plan.exercise_plan
    # @exercise_plan_content = @exercise_plan.day_plan_content

    if request.xhr?
      render layout: false
    end
  end

  def diet_plan
    @day_plan = DayPlan.find(params[:id])
    @diet_plan = @day_plan.diet_plan
    @diet_plan_content = @diet_plan.day_plan_content
  end

  def exercise_plan
    @day_plan = DayPlan.find(params[:id])
    # @exercise_plan = @day_plan.exercise_plan
    # @exercise_plan_content = @exercise_plan.day_plan_content
  end
end
