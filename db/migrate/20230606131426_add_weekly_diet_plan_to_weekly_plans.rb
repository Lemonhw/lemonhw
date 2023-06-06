class AddWeeklyDietPlanToWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_plans, :weekly_diet_plan, :text
  end
end
