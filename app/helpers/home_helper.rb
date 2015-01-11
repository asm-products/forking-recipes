module HomeHelper
  def recipe_thumbnail_path(recipe)
    image = recipe.recipe_images.first
    image ? image.image_url(:thumb) : image_path("fork_knife.png")
  end
end
