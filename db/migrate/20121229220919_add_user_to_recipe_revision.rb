class AddUserToRecipeRevision < ActiveRecord::Migration
  def change
    change_table :recipe_revisions do |t|
      t.references :users
    end
  end
end
