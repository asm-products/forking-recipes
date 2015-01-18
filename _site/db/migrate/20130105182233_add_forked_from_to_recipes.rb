class AddForkedFromToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :forked_from_recipe_id, :integer
  end
end
