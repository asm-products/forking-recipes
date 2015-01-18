class RecipeRevision < ActiveRecord::Base
  # attr_accessible :body, :commit_message, :revision, :title, :user, :recipe
  belongs_to :user
  belongs_to :recipe

  def previous
    RecipeRevision.where(recipe_id: recipe_id, revision: revision - 1).first if revision > 1
  end
end
