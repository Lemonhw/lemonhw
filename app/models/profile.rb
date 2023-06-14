class Profile < ApplicationRecord
  belongs_to :user
  has_many :weekly_plans, dependent: :destroy

  validates :name, :surname, :age, :height, :weight, :goal,
            :activity_level, :gender, :workout_difficulty, presence: true

  def ideal_weight_avg
    ideal_weight.values.sum / 4
  end
end
