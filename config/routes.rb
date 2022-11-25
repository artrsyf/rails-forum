Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :comments

  root 'posts#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
