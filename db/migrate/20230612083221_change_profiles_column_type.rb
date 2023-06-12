class ChangeProfilesColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :profiles, :bmi, "jsonb USING bmi::jsonb"
    change_column :profiles, :ideal_weight, "jsonb USING ideal_weight::jsonb"
    change_column :profiles, :daily_calories, "jsonb USING daily_calories::jsonb"
  end
end
