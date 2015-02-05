class HomeController < ApplicationController
  include RecipesHelper
  include UsersHelper

  def index
    if user_signed_in?
      followed_users = current_user.following
      @events = followed_users.map { |user| user.events.last(5) }.flatten.sort { |a, b| b.created_at <=> a.created_at }
      redirect_to :landing if @events.empty?
    else
      redirect_to :landing
    end
  end

  def landing
    @recipes = Recipe.limit(5)
  #   @recipes = RecipeImage.find([549, 376, 529, 526]).map(&:recipe)
  # rescue
  #   @recipes = []
  end

  def search
    query = params[:query]
    results  = PgSearch.multisearch(query)
    @recipes = Recipe.where("id IN (?)", results.map(&:searchable_id))
  end

  def browse
    @recipes = Recipe.includes(:recipe_images).uniq(:slug).last(100).reverse
  end
end
