class AddSlugToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :slug, :string

    add_index :recipes, :slug
  end
end
