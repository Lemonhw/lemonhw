class Profile < ApplicationRecord
  belongs_to :user
  has_many :weekly_plans, dependent: :destroy

  validates :name, :surname, :age, :height, :weight, :goal,
            :activity_level, :gender, :workout_difficulty, presence: true
end
