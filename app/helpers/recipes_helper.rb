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

  def recipe_upvote_path(recipe)
    recipe_path(recipe) + "/upvote"
  end

  def recipe_downvote_path(recipe)
    recipe_path(recipe) + "/downvote"
  end

  def new_recipe_path
    "/recipes/new"
  end

  def find_recipe_by_slug_and_username(slug, username)
    user_id = User.select(:id).find_by_username(username)

    Recipe.find_by_slug_and_user_id(slug, user_id)
  end
end
