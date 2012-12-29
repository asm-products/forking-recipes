class RecipeRevisionsController < ApplicationController
  def index
    @revisions = RecipeRevision.where(:recipe_id => params[:recipe_id])
    @recipe_id = params[:recipe_id]
  end

  def show
    @revision = RecipeRevision.find(params[:id])
    @recipe   = @revision.recipe
  end
end
