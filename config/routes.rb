Rails.application.routes.draw do
  resources :events
  resources :brands
  resources :payouts
  resources :offerings
  resources :uploads
  resources :categories
  resources :bookings
  resource :dashboard do
    resource :profile, :controller => 'dashboards', :action => 'profile'
    resource :account, :controller => 'dashboards', :action => 'account'
    resource :bookings, :controller => 'dashboards', :action => 'bookings'
  end
  resources :purchases
  resources :messages

  root to: 'visitors#landing'
  get 'visitors/index', :to => 'visitors#index'

  devise_for :users, :controllers => { :registrations => 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  
  ActiveAdmin.routes(self)
  mount_griddler

  # SEO stuff
  get 'event/:url_fragment', :controller => 'brands', :action => 'show', :as => 'nice_brand'
  get ':offering_name', :controller => 'offerings', :action => 'show', :as => 'nice_offering'
  
end
