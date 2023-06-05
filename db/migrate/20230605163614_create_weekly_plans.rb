class CreateWeeklyPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :weekly_plans do |t|
      t.string :fitness_goal
      t.integer :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
