class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_revisions
  attr_accessible :body, :commit_message, :revision, :title

  validates :commit_message, :presence => {:message => 'Commit Message cannot be blank'}
  validates :title, :presence => {:message => 'Commit Message cannot be blank'}
  validates :slug, :presence => {:message => 'Commit Message cannot be blank'}

  def increment_revision!
    self.revision = self.revision + 1
  end

  def create_recipe_revision!
    RecipeRevision.create(:user           => user,
                          :title          => title,
                          :body           => body,
                          :commit_message => commit_message,
                          :recipe         => self,
                          :revision       => revision)
  end
end
