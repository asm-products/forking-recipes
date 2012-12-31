class AddSlugToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :slug, :string, :null => false, :default => 'recipe'

    add_index :recipes, :slug, :unique => true
  end
end
