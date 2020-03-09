Rails.application.routes.draw do
  use_doorkeeper
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  apipie
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts
  root 'posts#index'
  resources :users do
    resources :posts
  end
  resources :posts, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
