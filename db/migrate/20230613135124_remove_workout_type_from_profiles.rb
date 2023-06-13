class RemoveWorkoutTypeFromProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :workout_type, :string
  end
end
