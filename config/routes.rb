Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  match "/browse" => "home#browse", via: :get
  match "/help" => 'home#help', via: :get
  match "/search" => "home#search", via: [:get, :post]

  root :to => "home#index"

  match "/recipes/random" => "recipes#random",  :via => :get, :as => :random_recipe

  resources :users, path: '' do
    member do
      post :follow
      post :unfollow
    end
    resources :recipes do
      resources :recipe_revisions, path: 'revisions', only: [:index, :show]
      member do
        get 'forks'
        post 'fork'
        get 'random'
        post 'star'
      end
    end
  end
end
