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

  def search
    query = params[:query]
    results  = PgSearch.multisearch(query)
    @recipes = Recipe.find_all_by_id(results.map(&:searchable_id))
  end

  def browse
    if cookies["visited"].nil?
      cookies["visited"] = true
      redirect_to "/browse#guider=first"
    end

    @recent_recipes  = Rails.cache.fetch("popular_recipes", :expires_in => 5.minutes) do
      Recipe.where(:forked_from_recipe_id => nil).last(10)
    end

    @popular_users   = Rails.cache.fetch("popular_users", :expires_in => 5.minutes) do
      User.all(:select => "users.*, COUNT(recipes.user_id) as recipe_count",
               :joins  => "LEFT JOIN recipes ON recipes.user_id = users.id",
               :group  => "users.id",
               :order  => "recipe_count DESC",
               :limit  => 10)
    end
  end
end
