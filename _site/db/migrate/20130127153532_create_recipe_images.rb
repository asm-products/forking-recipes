class CreateRecipeImages < ActiveRecord::Migration
  def change
    create_table :recipe_images do |t|
      t.references :recipes
      t.string :image
      t.timestamps
    end
  end
end
