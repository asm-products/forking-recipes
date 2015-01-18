module RecipesHelper
  def recipe_path(recipe)
     user_recipe_path(recipe.user, recipe)
  end

  def forks_path(recipe)
    forks_user_recipe_path(recipe.user, recipe)
  end

  def recipes_path(user)
    user_recipes_path(user)
  end

  def edit_recipe_path(recipe)
    edit_user_recipe_path(recipe.user, recipe)
  end

  def fork_recipe_path(recipe)
    fork_user_recipe_path(recipe.user, recipe)
  end

  def recipe_revisions_path(recipe)
    user_recipe_recipe_revisions_path(recipe.user, recipe)
  end

  def new_recipe_path
    new_user_recipe_path(current_user)
  end
end
