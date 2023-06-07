class UsersController < ApplicationController
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
    params.require(:user).permit(:name, :surname, :date_of_birth, :gender, :height)
  end
end
