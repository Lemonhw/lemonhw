class ChangeExercisePlansDayPlanContentToJsonb < ActiveRecord::Migration[7.0]
  def change
    change_column :exercise_plans, :day_plan_content, :jsonb, using: 'day_plan_content::jsonb'
  end
end
