class RecipesController < ApplicationController
  include RecipesHelper
  include UsersHelper

  before_filter :authenticate_user!, :except => [:show]

  def fork
    user_id = User.select(:id).find_by_username(params[:username])
    recipe = Recipe.find_by_slug_and_user_id(params[:recipe], user_id)

    respond_to do |format|
      if recipe.user_id != current_user.id && forked_recipe = recipe.fork_to(current_user)
        format.html { redirect_to "/#{forked_recipe.user.username}/#{forked_recipe.slug}", notice: 'Recipe was successfully forked.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index
    @recipes = Recipe.where(:user_id => current_user)
  end

  def show
    user_id = User.select(:id).find_by_username(params[:username])
    @recipe = Recipe.find_by_slug_and_user_id(params[:recipe], user_id)
    @forked_from_recipe = Recipe.find(@recipe.forked_from_recipe_id) if @recipe.forked_from_recipe_id

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
### Steps
* put water in cup
### Pictures
![my_image](imgur.com/my_image)
body

    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end

  def edit
    user_id = User.select(:id).find_by_username(params[:username])
    @recipe = Recipe.find_by_slug_and_user_id(params[:recipe], user_id)
  end

  def create
    @recipe          = Recipe.new(params[:recipe_form])
    @recipe.revision = 1
    @recipe.user     = current_user
    @recipe.slug     = @recipe.title.parameterize
    @recipe.create_recipe_revision!

    respond_to do |format|
      if @recipe.save
        Event.create(:user_id => @recipe.user.id, :recipe_id => @recipe.id, :action => "created")
        format.html { redirect_to "/#{@recipe.user.username}/#{@recipe.slug}", notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    user_id = User.select(:id).find_by_username(params[:username])
    @recipe = Recipe.find_by_slug_and_user_id(params[:recipe], user_id)
    @recipe.increment_revision!

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe_form])
        Event.create(:user_id => @recipe.user.id, :recipe_id => @recipe.id, :action => "updated")
        @recipe.create_recipe_revision!
        format.html { redirect_to "/#{@recipe.user.username}/#{@recipe.slug}", notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    user = User.find_by_username(params[:username])
    @recipe = Recipe.find_by_slug_and_user_id(params[:recipe], user.id)
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_path(user) }
      format.json { head :no_content }
    end
  end
end
