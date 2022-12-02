Rails.application.routes.draw do
  get 'comments/create'
  get 'profiles/show'
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end

  root 'posts#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
