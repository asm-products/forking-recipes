class AddRecipeIdToRecipeRevision < ActiveRecord::Migration
  def change
    change_table :recipe_revisions do |t|
      t.references :recipes
    end
  end
end
