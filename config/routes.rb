Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: {
    registrations: 'devise/sessions'
  }

  get 'dashboard', to: 'dashboards#show', as: :dashboard

  resources :weekly_plans, only: [:new, :create, :show, :index] do
    resources :day_plans, only: [:show]
  end
end
