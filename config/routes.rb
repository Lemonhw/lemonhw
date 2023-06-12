Rails.application.routes.draw do
  root to: 'pages#home'

  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  get 'redirect', to: 'redirects#index', as: :redirect

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:edit, :update]

  resources :profiles, only: [:new, :create]

  resources :videos, only: [:index, :show]

  get 'dashboard', to: 'dashboards#show', as: :dashboard

  resources :weekly_plans, only: [:new, :create, :show, :index] do
    resources :day_plans, only: [:show] do
      member do
        get :diet_plan
        get :exercise_plan
      end
    end
  end
end
