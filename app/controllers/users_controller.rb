class UsersController < ApplicationController

  def complete_signup
    @user = User.find(params[:id])
    redirect_to dashboard_path
  end
end
