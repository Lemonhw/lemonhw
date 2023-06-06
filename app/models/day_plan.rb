class DayPlan < ApplicationRecord
  belongs_to :weekly_plan
  has_many :diet_plans, :exercise_plans
end
