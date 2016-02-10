Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :offerings
  resources :uploads
  resources :categories
  resources :bookings
  resource :dashboard
  resources :purchases

  root to: 'visitors#landing'
  get 'visitors/index', :to => 'visitors#index'

  devise_for :users, :controllers => { :registrations => 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }


end
