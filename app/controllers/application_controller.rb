class ApplicationController < ActionController::Base
  before_filter :set_up_side_bar_variables
  protect_from_forgery

  def set_up_side_bar_variables
    if current_user
      @recipes = Recipe.where(:user_id => current_user.id)
    else
      @users = User.all(:select => "users.*, COUNT(recipes.user_id) as recipe_count",
                 :joins  => "LEFT JOIN recipes ON recipes.user_id = users.id",
                 :group  => "users.id",
                 :order  => "recipe_count DESC",
                 :limit  => 10)
    end
  end
end
