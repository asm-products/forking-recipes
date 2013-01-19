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

    @images = Rails.cache.fetch("popular_images", :expires_in => 5.minutes) do
      recipes = Recipe.where(:forked_from_recipe_id => nil).last(50)

      recipes.inject({}) do |image_map, recipe|
        image_map.merge(recipe => recipe.body.scan(/!\[.*]\((.*)\)/).flatten[0..1])
      end
    end
  end
end
