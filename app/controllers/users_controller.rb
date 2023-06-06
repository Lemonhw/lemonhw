class UsersController < ApplicationController

  def complete_signup
    @user = User.find(params[:id])
  end
end
