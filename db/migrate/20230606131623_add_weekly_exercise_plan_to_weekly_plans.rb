class AddWeeklyExercisePlanToWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_plans, :weekly_exercise_plan, :text
  end
end
