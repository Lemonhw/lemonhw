class AddWorkoutInfoToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :workout_difficulty, :string
    add_column :profiles, :workout_type, :string
  end
end
