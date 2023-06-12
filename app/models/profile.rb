class Profile < ApplicationRecord
  belongs_to :user

  validates :name, :surname, :age, :height, :weight, :goal, :activity_level, :gender, presence: true
end
