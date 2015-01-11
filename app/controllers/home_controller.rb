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
    recipe_images = RecipeImage.find([549, 376, 529, 526])

    @images = recipe_images.map do |image|
      [image.image_url(:thumb), image.recipe]
    end
  rescue
    @images = []
  end

  def search
    query = params[:query]
    results  = PgSearch.multisearch(query)
    @recipes = Recipe.find_all_by_id(results.map(&:searchable_id))
  end

  def browse
    @recipes = Recipe.includes(:recipe_images).uniq_by(&:slug).last(100).reverse
  end
end
