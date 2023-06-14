Rails.application.routes.draw do
  root to: 'pages#home'

  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  get 'redirect', to: 'redirects#index', as: :redirect

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:edit, :update]

  resource :profile, only: [:new, :create, :edit, :update]
  get 'profile/result', to: 'profiles#result', as: 'result_profile'

  # resources :videos, only: [:index, :show]

  get 'dashboard', to: 'dashboards#show', as: :dashboard

  resources :dashboards, only: [] do
    collection do
      get :overview
      get :exercise_plan
      get :diet_plan
      get :videos
      get :video
    end
  end


  resources :weekly_plans, only: [:new, :create, :show, :index] do
    resources :day_plans, only: [:show] do
      member do
        get :diet_plan
        get :exercise_plan
      end
    end
  end
end
