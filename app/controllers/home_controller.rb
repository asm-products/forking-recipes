class HomeController < ApplicationController
  include RecipesHelper
  include UsersHelper

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
    @users   = User.last(10)
  end
end
