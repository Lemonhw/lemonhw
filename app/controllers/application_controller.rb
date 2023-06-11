class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:home]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me, profile_attributes: [:name, :surname, :age, :height, :weight, :goal, :activity_level, :gender, :avatar]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :remember_me, profile_attributes: [:name, :surname, :age, :height, :weight, :goal, :activity_level, :gender]])
  end
end
