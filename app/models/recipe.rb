class Recipe < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :commit_message, :revision, :title

  def increment_revision!
    self.revision = self.revision + 1
  end

  def create_recipe_revision!
    RecipeRevision.create(:user           => user,
                          :title          => title,
                          :body           => body,
                          :commit_message => commit_message,
                          :revision       => revision)
  end
end
