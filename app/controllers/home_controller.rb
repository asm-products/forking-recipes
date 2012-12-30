class HomeController < ApplicationController
  def index
    if current_user
      redirect_to recipes_path
    else
      @recipes = Recipe.last(10)
    end
  end
end
