# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  resources :likes, only: %i[create destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'authentications/omniauth_callbacks' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'posts#index'
  resources :comments, only: %i[destroy]
  namespace :api do
    resources :posts, only: %i[index show create destroy] do
      resources :comments, only: %i[create destroy]
    end
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[destroy]
    devise_scope :user do
      post '/sessions' => 'sessions#create'
      delete '/sessions' => 'sessions#destroy'
      post '/registrations' => 'registrations#create'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
