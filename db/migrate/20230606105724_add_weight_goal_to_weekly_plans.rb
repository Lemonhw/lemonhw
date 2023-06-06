class AddWeightGoalToWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_plans, :weight_goal, :integer
  end
end
