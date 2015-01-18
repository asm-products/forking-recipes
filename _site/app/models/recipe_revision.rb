class RecipeRevision < ActiveRecord::Base
  # attr_accessible :body, :commit_message, :revision, :title, :user, :recipe
  belongs_to :user
  belongs_to :recipe
end
