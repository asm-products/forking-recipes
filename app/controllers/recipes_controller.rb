class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @recipes = Recipe.where(:user_id => current_user)
  end

  def show
    @recipe = Recipe.find(params[:id] || params[:recipe])

    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end

  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe          = Recipe.new(params[:recipe])
    @recipe.revision = 1
    @recipe.user     = current_user
    @recipe.create_recipe_revision!

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html { render action: "new" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.increment_revision!

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
         @recipe.create_recipe_revision!
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end
end
