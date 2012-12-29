class RecipeRevision < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  attr_accessible :body, :commit_message, :revision, :title, :user, :recipe
end
