class WeeklyPlan < ApplicationRecord
  belongs_to :user
  has_many :day_plans
end
