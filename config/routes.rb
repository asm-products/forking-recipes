RecipeHub::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  resources :recipes do
    resources :recipe_revisions, :only => [:index, :show]
  end

  match "users/:username"         => "users#show"
  resources :users, :only => [:show]

  root :to => 'recipes#index', :constraints => lambda { |r| r.env['warden'].authenticate? }
  root :to => "home#index"
end
