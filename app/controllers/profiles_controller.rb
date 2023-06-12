class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @profile = Profile.new
  end

  def show
    @profile = current_user.profile
  end

  def create
    Profile.create(profile_params.merge({user_id: current_user.id}))
    @profile = Profile.find(current_user.id)
    fitness_client = FitnessApiClient.new(@profile)
    bmi = fitness_client.calc_bmi
    daily_calories = fitness_client.calc_daily_calories
    ideal_weight = fitness_client.calc_ideal_weight
    @profile.update(bmi: bmi, daily_calories: daily_calories, ideal_weight: ideal_weight)
    @profile.save

    redirect_to redirect_path, notice: 'Profile successfully created.'
  end

  def result
    @profile = current_user.profile
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :surname, :age, :height, :weight, :goal, :activity_level, :gender)
  end
end
