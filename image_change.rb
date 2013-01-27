recipes = Recipe.all

images_to_recipes = recipes.inject({}) do |hash, recipe|
  images = recipe.body.scan(/!\[.*\]\((.*)\)/).flatten
  images_to_recipes = images.map { |i| [i, [recipe]] }

  hash.merge!(Hash[images_to_recipes]) do |key, oldval, newval|
    oldval + newval
  end
end

images_to_recipes.each do |image, recipes|
  recipes.each do |recipe|
    #ri = RecipeImage.create!(:recipes_id => recipe.id, :image => open(image))
    new_body = recipe.body.gsub(image, ri.image.to_s)
    recipe.update_attributes(:body => new_body)
  end
end
