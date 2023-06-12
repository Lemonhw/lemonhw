class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  # def age
  #   birth_date = current_user.date_of_birth
  #   current_date = Date.today
  #   user_age = current_date.year - birth_date.year
  #   user_age -= 1 if current_date.month < birth_date.month || (current_date.month == birth_date.month && current_date.day < birth_date.day)
  # end
end
