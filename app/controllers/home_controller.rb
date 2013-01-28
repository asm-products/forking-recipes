class HomeController < ApplicationController
  include RecipesHelper
  include UsersHelper

  def index
    if user_signed_in?
      followed_users = current_user.following
      @events = followed_users.map { |user| user.events.last(5) }.flatten.sort { |a, b| b.created_at <=> a.created_at }
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

    @images = Rails.cache.fetch("popular_images", :expires_in => 5.minutes) do
      recipe_images = RecipeImage.includes(:recipe).last(75).shuffle

      recipe_images.map do |image|
        [image.image_url(:thumb), image.recipe]
      end.reject do |image, recipe|
        recipe.nil?
      end.uniq { |i, r| r.slug }
    end
  end
end
