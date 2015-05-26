class HomeController < ApplicationController
  include RecipesHelper
  include UsersHelper
  before_action :load_events, only: [:index]

  def index
    # redirect_to :landing if @events.empty?

    image_id_array = [549, 376, 529, 526]
    if image_id_array.all? {|image_id| RecipeImage.exists? image_id }
      recipe_images = RecipeImage.find image_id_array

      @images = recipe_images.map do |image|
        [image.image_url(:thumb), image.recipe]
      end
    else
      @images = []
    end
  end

  def search
    query = params[:query]
    results  = PgSearch.multisearch(query)
    @recipes = Recipe.where("id IN (?)", results.map(&:searchable_id))
  end

  def browse
    @recipes = Recipe.includes(:recipe_images).uniq(:slug).last(100).reverse
  end

  private

  def load_events
    if user_signed_in?
      followed_users = current_user.following
      @events = followed_users.map { |user| user.events.last(5) }.flatten.sort { |a, b| b.created_at <=> a.created_at }
    else
      @events = nil
    end
  end
end
