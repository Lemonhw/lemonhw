class WeeklyPlan < ApplicationRecord
  belongs_to :user
  has_many :day_plans

  def next_plan
    user.weekly_plans.where('created_at > ?', created_at).order(created_at: :asc).first
  end
end
