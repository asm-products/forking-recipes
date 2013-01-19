module RecipesHelper
  def recipe_path(recipe)
    return "/#{recipe.user.username}/#{recipe.slug}" if recipe.user

    "/recipes/new"
  end

  def forks_path(recipe)
    recipe_path(recipe) + "/forks"
  end

  def recipes_path(user)
    "/#{user.username}"
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

  def new_recipe_path
    "/recipes/new"
  end
end
