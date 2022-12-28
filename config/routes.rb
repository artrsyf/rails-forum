Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'comments/create'
  resources :profiles
  resources :rooms do
    resources :messages
  end
  post 'rooms/create'
  post 'reposts/create'
  post 'posts_controller/index/:post_index' => 'posts_controller#index'
  devise_for :users, controllers: { registrations: 'registrations'}
  get '/user' => "profiles#create", :as => :user_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
    member do
      post 'upvote', to: 'posts#upvote'
    end
  end

  root 'posts#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
