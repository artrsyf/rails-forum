Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
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
    post 'posts/repost'
    root 'posts#index'
    post 'messages/create_repost_message'
    # Defines the root path route ("/")
    # root "articles#index"
  end
end
