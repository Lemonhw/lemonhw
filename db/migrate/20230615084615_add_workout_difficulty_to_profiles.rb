class AddWorkoutDifficultyToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :workout_difficulty, :string
  end
end
