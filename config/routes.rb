RecipeHub::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  match "/browse"                      => "home#browse"
  match "/:username"                   => "Users#show"
  match "/:username/:recipe"           => "Recipes#show",    :via => :get
  match "/:username/:recipe"           => "Recipes#destroy", :via => :delete
  match "/:username/:recipe"           => "Recipes#update",  :via => :put
  match "/:username/:recipe/edit"      => "Recipes#edit"
  match "/:username/:recipe/fork"      => "Recipes#fork"
  match "/:username/:recipe/revisions" => "RecipeRevisions#index"
  match "/:username/:recipe/revisions/:revision_id" => "RecipeRevisions#show"

  root :to => "home#index"
end
