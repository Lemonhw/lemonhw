Rails.application.routes.draw do
  root to: 'pages#home'

  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  get 'redirect', to: 'redirects#index', as: :redirect

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:edit, :update]

  get 'dashboard', to: 'dashboards#show', as: :dashboard

  resources :weekly_plans, only: [:new, :create, :show, :index] do
    resources :day_plans, only: [:show]
  end
end
