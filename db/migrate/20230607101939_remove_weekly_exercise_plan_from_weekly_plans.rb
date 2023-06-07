class RemoveWeeklyExercisePlanFromWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    remove_column :weekly_plans, :weekly_exercise_plan, :text
  end
end
