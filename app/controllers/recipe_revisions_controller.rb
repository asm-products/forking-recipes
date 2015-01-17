class RecipeRevisionsController < ApplicationController
  include RecipesHelper
  before_filter :get_recipe

  def index
    @user             = @recipe.user
    @revisions        = RecipeRevision.where(recipe_id: @recipe.id)
    @recipe_permalink = @recipe.slug
  end

  def show
    @revision = RecipeRevision.find(params[:id])

    if params[:target_id].present?
      @target_revision = RecipeRevision.find(params[:target_id])
    elsif @revision.revision > 1
      @target_revision = RecipeRevision.where(recipe_id: @revision.recipe_id, revision: @revision.revision - 1).first
    else
      @diff = "Not Available"
    end
    @diff ||= Differ.diff_by_line(@revision.body, @target_revision.body).format_as(:html).html_safe
  end

  private

  def get_recipe
    @user = User.find_by_username(params[:user_id])
    @recipe = @user.recipes.find_by_slug(params[:recipe_id])
    return render inline: "We couldn't find that recipe in our system :(" unless @recipe
  end
end
