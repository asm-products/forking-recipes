class ApplicationController < ActionController::Base
  before_filter :set_up_side_bar_variables
  protect_from_forgery

  def set_up_side_bar_variables
    if current_user
      @recipes = Recipe.where(:user_id => current_user.id)
    else
      @recipes = Recipe.where(:forked_from_recipe_id => nil).last(10)
    end
  end
end
