class DayPlan < ApplicationRecord
  belongs_to :weekly_plan
  has_one :diet_plan
  has_one :exercise_plan
end
