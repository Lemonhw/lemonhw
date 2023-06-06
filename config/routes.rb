Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'users/:id/complete_signup', to: 'users#complete_signup', as: :complete_signup


  get 'dashboard', to: 'dashboards#show', as: :dashboard

  resources :weekly_plans, only: [:new, :create, :show, :index] do
    resources :day_plans, only: [:show]
  end
end
