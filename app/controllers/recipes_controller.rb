class RecipesController < ApplicationController
  include RecipesHelper
  include UsersHelper

  before_filter :authenticate_user!, :except => [:show, :forks]

  def upvote
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
    current_user.up_vote!(@recipe)

    redirect_to recipe_path(@recipe)
  end

  def downvote
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
    current_user.down_vote!(@recipe)

    redirect_to recipe_path(@recipe)
  end

  def fork
    recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])

    respond_to do |format|
      if recipe.user_id != current_user.id && forked_recipe = recipe.fork_to(current_user)
        format.html { redirect_to "/#{forked_recipe.user.username}/#{forked_recipe.slug}", notice: 'Recipe was successfully forked.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def forks
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
    @forked_recipes = Recipe.where(:forked_from_recipe_id => @recipe.id)
  end

  def index
    @recipes = Recipe.where(:user_id => current_user)
  end

  def show
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
    @revision_count = RecipeRevision.where(:recipe_id => @recipe.id).count
    @forked_from_recipe = Recipe.find(@recipe.forked_from_recipe_id) if @recipe.forked_from_recipe_id

    @forks  = Rails.cache.fetch("recipe_#{@recipe.id}_forked_count", :expires_in => 5.minutes) do
      Recipe.where(:forked_from_recipe_id => @recipe.id).count
    end

    @upvotes = @recipe.up_votes
    @downvotes = @recipe.down_votes

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
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
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
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
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
    @recipe = find_recipe_by_slug_and_username(params[:recipe], params[:username])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_path(User.find_by_username(params[:username])) }
      format.json { head :no_content }
    end
  end
end
