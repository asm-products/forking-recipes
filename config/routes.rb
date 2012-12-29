RecipeHub::Application.routes.draw do
  root :to => "home#index"

  devise_for :users

  devise_scope :user do
    get "sign_out", :to => "devise/sessions#destroy"
    get "sign_in",  :to => "devise/sessions#create"
  end

  resources :recipes
end
