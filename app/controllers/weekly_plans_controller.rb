class WeeklyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]


  def index
  end

  def show
  end

  def new
    @weekly_plan = WeeklyPlan.new
  end

  def create
  end
end
