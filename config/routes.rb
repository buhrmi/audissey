Rails.application.routes.draw do
  resources :offerings
  resource :dashboard do

  end
  resources :uploads
  resources :categories
  root to: 'visitors#landing'
  get 'visitors/index', :to => 'visitors#index'
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :offerings

end
