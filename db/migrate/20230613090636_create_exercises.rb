class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :type
      t.string :muscle
      t.string :difficulty
      t.text :instructions

      t.timestamps
    end
  end
end
