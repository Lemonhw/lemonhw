class User < ApplicationRecord
  has_one_attached :avatar
  has_many :weekly_plans
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def age
    user = current_user
  end
end
