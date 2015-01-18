class RecipeRevisionsController < ApplicationController
  include RecipesHelper
  before_filter :get_recipe
  before_filter :get_revision, only: [:show]

  def index
    @user             = @recipe.user
    @revisions        = RecipeRevision.where(recipe_id: @recipe.id)
    @recipe_permalink = @recipe.slug
  end

  def show
    @target_revision = if params[:target_id].present?
      RecipeRevision.find(params[:target_id])
    else
      @revision.previous
    end

    @diff = "Not Available" unless @target_revision.present?
    @diff ||= Differ.diff_by_line(@revision.body, @target_revision.body).format_as(:html).html_safe
  end

  private
  def get_revision
    @revision = RecipeRevision.find(params[:id])
  end

  def get_recipe
    @user = User.find_by_username(params[:user_id])
    @recipe = @user.recipes.find_by_slug(params[:recipe_id])
    return render inline: "We couldn't find that recipe in our system :(" unless @recipe
  end
end
