class ChangeDietPlansDayPlanContentToJsonb < ActiveRecord::Migration[7.0]
  def change
    change_column :diet_plans, :day_plan_content, :jsonb, using: 'day_plan_content::jsonb'
  end
end
