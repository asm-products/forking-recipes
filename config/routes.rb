RecipeHub::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  resources :recipes do
    resources :recipe_revisions, :only => [:index, :show]
  end

  match "/browse"                      => "home#browse"
  match "/:username"                   => "Users#show"
  match "/:username/:recipe"           => "Recipes#show"
  match "/:username/:recipe/fork"      => "Recipes#fork"
  match "/:username/:recipe/revisions" => "RecipeRevisions#index"
  match "/:username/:recipe/revisions/:revision_id" => "RecipeRevisions#show"

  root :to => "home#index"
end
