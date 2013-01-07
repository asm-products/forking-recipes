class AddFollowingTable < ActiveRecord::Migration
  def change
    create_table :follow, :id => false do |t|
      t.integer :following_id
      t.integer :follower_id
    end
  end
end
