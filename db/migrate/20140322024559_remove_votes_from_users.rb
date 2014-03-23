class RemoveVotesFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :up_votes
    remove_column :users, :down_votes
  end

  def down
    add_column :users, :up_votes, :integer
    add_column :users, :down_votes, :integer
  end
end
