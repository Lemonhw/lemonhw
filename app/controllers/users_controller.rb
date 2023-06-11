class UsersController < ApplicationController
  before_action :set_resource

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @weekly_plans = @user.weekly_plans.order(created_at: :desc)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :age, :gender, :height, :weight, :goal, :activity_level)
  end

  def set_resource
    @resource = User.new
    @resource_name = :user
  end
end
