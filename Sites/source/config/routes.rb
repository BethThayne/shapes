Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  resources :items 
  
  resources :users

  resources :categories

  resource :session

  # users can only edit one account
  resource :account

  get "about", to: "pages#about"
  
  root "pages#home"

end
