class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.integer :height
      t.integer :weight
      t.string :goal
      t.string :activity_level
      t.string :gender
      t.string :bmi
      t.string :ideal_weight
      t.string :daily_calories
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
