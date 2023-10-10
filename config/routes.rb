Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'posts#index'
  delete '/comments/:id/posts' => 'comments#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
