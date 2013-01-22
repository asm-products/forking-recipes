class RecipeRevisionsController < ApplicationController
  include RecipesHelper

  def index
    @recipe = find_by_slug_and_username(params[:recipe], params[:username])
    @user             = @recipe.user
    @revisions        = RecipeRevision.where(:recipe_id => @recipe.id)
    @recipe_permalink = @recipe.slug
  end

  def show
    revision = RecipeRevision.find(params[:revision_id])

    if revision.revision > 1
      previous_revision = RecipeRevision.where(:recipe_id => revision.recipe_id,
                                               :revision => revision.revision - 1).first

      @diff = Differ.diff_by_line(revision.body, previous_revision.body).format_as(:html).html_safe
    else
      @diff = "Not Available"
    end
  end
end
