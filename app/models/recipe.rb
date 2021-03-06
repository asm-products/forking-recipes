class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_revisions

  has_many :events
  has_many :recipe_images
  has_many :forks, class_name: "Recipe", foreign_key: :forked_from_recipe_id
  has_many :revisions, class_name: "RecipeRevision"
  has_many :stars

  validates :commit_message, :presence => {:message => 'Update Message cannot be blank'}
  validates :title, :presence => {:message => 'Title cannot be blank'}

  validates_uniqueness_of :slug, :scope => :user_id

  include PgSearch

  multisearchable :against => [:title, :body]

  acts_as_taggable

  def forked_from
    Recipe.find(forked_from_recipe_id)
  end

  def to_param
    slug
  end

  def increment_revision!
    self.revision = self.revision + 1
  end

  def number_of_forks
    forks.count
  end

  def number_of_stars
    stars.count
  end

  def create_recipe_revision!
    RecipeRevision.create(:user           => user,
                          :title          => title,
                          :body           => body,
                          :commit_message => commit_message,
                          :recipe         => self,
                          :revision       => revision)
  end

  def valid_body?
    return true if RDiscount.new(body).to_html
  rescue
    false
  end

  def upload_images!
    images = self.body.scan(/!\[.*\]\((.*)\)/).flatten
    images.reject! { |i| i.include?('forkingrecipes') }
    images_to_recipe_images = images.map do |i|
      begin
        [i, RecipeImage.create!(:recipe => self, :image => open(i))]
      rescue
        nil
      end
    end.compact

    current_body = self.body

    images_to_recipe_images.each do |image_url, recipe_image|
      current_body = current_body.gsub(image_url, recipe_image.image.to_s)
    end

    self.update_attributes(:body => current_body)
  rescue
  end

  def fork_to(user)
    recipe = Recipe.new(:title => title,
                        :body => body,
                        :user => user,
                        :commit_message => "Forked From #{self.user.username}",
                        :slug => slug,
                        :forked_from_recipe_id => self.id,
                        :revision => 1)

    recipe.create_recipe_revision!

    return recipe
  end
end
