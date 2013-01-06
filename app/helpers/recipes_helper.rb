module RecipesHelper
  def recipe_path(recipe)
    "/#{@recipe.user.username}/#{@recipe.slug}"
  end

  def edit_recipe_path(recipe)
    recipe_path(recipe) + "/edit"
  end

  def fork_recipe_path(recipe)
    recipe_path(recipe) + "/fork"
  end

  def recipe_revisions_path(recipe)
    recipe_path(recipe) + "/revisions"
  end
end
