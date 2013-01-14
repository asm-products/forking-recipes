class HomeController < ApplicationController
  include RecipesHelper
  include UsersHelper

  caches_action :browse

  def index
    if user_signed_in?
      followed_users = current_user.following
      @events = followed_users.map { |user| user.events.limit(5) }.flatten.sort_by { |event| event.created_at }
      redirect_to :browse if @events.empty?
    else
      redirect_to :browse
    end
  end

  def browse
    @recipes = Recipe.where(:forked_from_recipe_id => nil).last(10)
    @users   = User.all(:select => "users.*, COUNT(recipes.user_id) as recipe_count",
                        :joins  => "LEFT JOIN recipes ON recipes.user_id = users.id",
                        :group  => "users.id",
                        :order  => "recipe_count DESC",
                        :limit  => 10)
  end
end
