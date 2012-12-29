RecipeHub::Application.routes.draw do
  root :to => "home#index"

  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  resources :recipes do
    resources :recipe_revisions, :only => [:index, :show]
  end

end
