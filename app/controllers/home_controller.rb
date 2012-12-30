class HomeController < ApplicationController
  def index
    if current_user
      @recipes = Recipe.where(:user_id => current_user.id).last(10)
    else
      @recipes = Recipe.last(10)
    end
  end
end
