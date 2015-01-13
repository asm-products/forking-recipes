class RecipesController < ApplicationController
  include RecipesHelper
  include UsersHelper

  before_filter :authenticate_user!, :except => [:show, :forks, :random]
  before_filter :get_recipe, :except => [:index, :new, :create, :random]

  def star
    current_user.star(@recipe)
    redirect_to recipe_path(@recipe)
  end

  def random
    recipe = Recipe.where("forked_from_recipe_id IS NULL").order("RANDOM()").limit(1).first
    redirect_to recipe_path(recipe)
  end

  def fork
    respond_to do |format|
      if @recipe.user != current_user && forked_recipe = @recipe.fork_to(current_user)
        format.html { redirect_to recipe_path(forked_recipe), notice: 'Recipe was successfully forked.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def forks
    @forked_recipes = Recipe.where(:forked_from_recipe_id => @recipe.id)
  end

  def index
    @recipes = Recipe.where(:user_id => current_user)
  end

  def show
    @revision_count = RecipeRevision.where(:recipe_id => @recipe.id).count
    @forked_from_recipe = Recipe.find_by_id(@recipe.forked_from_recipe_id) if @recipe.forked_from_recipe_id

    @page_title = "ForkingRecipes - #{@recipe.user.username} / #{@recipe.title}"

    @forks  = Recipe.where(:forked_from_recipe_id => @recipe.id).count

    @star_count = @recipe.number_of_stars

    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end

  def new
    @recipe = Recipe.new(:body => <<body)
### Source
[some_blog](http://www.someblog.com/recipe)

### Ingredients
* 1 cup of water

### Directions
1. put water in cup

### Pictures
![my_image](imgur.com/my_image)
body
  end

  def edit
  end

  def create
    @recipe          = Recipe.new(params[:recipe])
    @recipe.revision = 1
    @recipe.user     = current_user
    @recipe.slug     = @recipe.title.parameterize

    respond_to do |format|
      if @recipe.valid_body? && @recipe.save
        @recipe.create_recipe_revision!
        @recipe.upload_images!
        Event.create(:user_id => @recipe.user.id, :recipe_id => @recipe.id, :action => "created")
        format.html { redirect_to [current_user, @recipe], notice: 'Recipe was successfully created.' }
      else
        @recipe.user = nil
        format.html { render action: "new" }
      end
    end
  end

  def update
    @recipe.increment_revision!

    respond_to do |format|
      if @recipe.valid_body? && @recipe.update_attributes(params[:recipe])
        Event.create(:user_id => @recipe.user.id, :recipe_id => @recipe.id, :action => "updated")
        @recipe.upload_images!
        @recipe.create_recipe_revision!
        format.html { redirect_to [@recipe.user, @recipe], notice: 'Recipe was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    Event.where(:recipe_id => @recipe.id).destroy_all
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_path(User.find_by_username(params[:user_id])) }
    end
  end

  private
  def get_recipe
    @user = User.find_by_username(params[:user_id])
    @recipe = @user.recipes.find_by_slug(params[:id])
    return render :inline => "We couldn't find that recipe in our system :(" unless @recipe
  end
end
