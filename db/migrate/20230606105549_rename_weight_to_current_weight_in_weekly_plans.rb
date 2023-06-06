class RenameWeightToCurrentWeightInWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    rename_column :weekly_plans, :weight, :current_weight
  end
end
