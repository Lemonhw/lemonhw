class ChangeColumnInExercises < ActiveRecord::Migration[7.0]
  def change
    rename_column :exercises, :type, :exercise_type
  end
end
