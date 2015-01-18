class ChangeRecipesIdToRecipe < ActiveRecord::Migration
  def change
    rename_column :recipe_images, :recipes_id, :recipe_id
  end
end
