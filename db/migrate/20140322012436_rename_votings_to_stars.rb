class RenameVotingsToStars < ActiveRecord::Migration
  def up
    rename_table :votings, :stars
    remove_column :stars, :voteable_type
    rename_column :stars, :voteable_id, :recipe_id
    remove_column :stars, :voter_type
    rename_column :stars, :voter_id, :user_id
    remove_column :stars, :up_vote
    remove_column :stars, :id
  end

  def down
  end
end
