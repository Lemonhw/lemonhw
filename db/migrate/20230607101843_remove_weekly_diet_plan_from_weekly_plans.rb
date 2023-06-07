class RemoveWeeklyDietPlanFromWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    remove_column :weekly_plans, :weekly_diet_plan, :text
  end
end
