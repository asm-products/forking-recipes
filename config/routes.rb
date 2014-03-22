RecipeHub::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  match "/browse"                      => "home#browse"
  match "/help"                        => 'home#help'
  match "/search"                      => "home#search"
  match "/recipes/new"                 => "recipes#new",     :via => :get
  match "/recipes/new"                 => "recipes#create",  :via => :post
  match "/:username"                   => "Users#show"
  match "/:username/follow"            => "Users#follow",    :via => :post
  match "/:username/unfollow"          => "Users#unfollow",  :via => :post
  match "/:username/:recipe"           => "recipes#show",    :via => :get, :as => :recipe_path
  match "/:username/:recipe"           => "recipes#destroy", :via => :delete
  match "/:username/:recipe"           => "recipes#update",  :via => :put
  match "/:username/:recipe/edit"      => "recipes#edit"
  match "/:username/:recipe/fork"      => "recipes#fork"
  match "/:username/:recipe/star"      => "recipes#star",    :via => :post, :as => :recipe_star
  match "/:username/:recipe/forks"     => "recipes#forks"
  match "/:username/:recipe/revisions" => "recipeRevisions#index"
  match "/:username/:recipe/revisions/:revision_id" => "RecipeRevisions#show"

  root :to => "home#index"
end
