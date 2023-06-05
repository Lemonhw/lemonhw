class CreateExercisePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_plans do |t|
      t.string :day_plan_content
      t.references :day_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
