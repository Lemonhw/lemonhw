class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:name, :surname, :date_of_birth, :height, :weight, :goal, :activity_level, :gender])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, profile_attributes: [:name, :surname, :date_of_birth, :height, :weight, :goal, :activity_level, :gender])
  end

  protected

  def after_sign_up_path_for(_resource)
    new_profile_path # or wherever you want to redirect
  end
end
