class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :title
      t.integer :user_id
      t.integer :revision
      t.text :body

      t.timestamps
    end
  end
end
