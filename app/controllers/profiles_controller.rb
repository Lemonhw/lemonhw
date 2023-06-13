class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @profile = Profile.new
  end

  def show
    @profile = current_user.profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    fitness_client = FitnessApiClient.new(@profile)
    bmi = fitness_client.calc_bmi
    daily_calories = fitness_client.calc_daily_calories
    ideal_weight = fitness_client.calc_ideal_weight

    @profile.bmi = bmi
    @profile.daily_calories = daily_calories
    @profile.ideal_weight = ideal_weight

    if @profile.save
      redirect_to dashboard_path, notice: 'Profile successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def result
    @profile = current_user.profile
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :surname, :age, :height, :weight, :goal, :activity_level, :gender)
  end
end
