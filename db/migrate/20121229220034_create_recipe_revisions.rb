class CreateRecipeRevisions < ActiveRecord::Migration
  def change
    create_table :recipe_revisions do |t|
      t.string :title
      t.text :body
      t.string :commit_message
      t.references :user
      t.integer :revision

      t.timestamps
    end
    add_index :recipe_revisions, :user_id
  end
end
