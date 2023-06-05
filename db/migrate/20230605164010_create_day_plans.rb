class CreateDayPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :day_plans do |t|
      t.integer :day_number
      t.references :weekly_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
