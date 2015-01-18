class RemoveVotesFromRecipes < ActiveRecord::Migration
  def up
    remove_column :recipes, :up_votes
    remove_column :recipes, :down_votes
  end

  def down
    add_column :recipes, :up_votes, :integer
    add_column :recipes, :down_votes, :integer
  end
end
