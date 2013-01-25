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
      recipes = Recipe.last(50).shuffle

      recipes.inject({}) do |image_map, recipe|
        images = recipe.body.scan(/!\[.*\]\((.*)\)/).flatten.last(2)
        images_to_recipes = images.map { |i| [i, recipe] }

        image_map.merge!(Hash[images_to_recipes]) do |key, oldval, newval|
          oldval
        end
      end
    end
  end
end
