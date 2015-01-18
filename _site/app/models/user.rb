class User < ActiveRecord::Base
  validates :username, :uniqueness => true
  validates_format_of :username, :with => /^[a-zA-Z0-9_]*$/, :multiline => true, :on => :create

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :events
  has_many :recipes

  has_many :followed_users, :through => :relationships, :source => :followed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

  def to_param
    username
  end

  def starred_recipes
    ids = Star.where(:user_id => self.id).pluck(:recipe_id)

    Recipe.where("id IN (?)", ids)
  end

  def star(recipe)
    Star.create(:user_id => self.id, :recipe_id => recipe.id)
  end

  def remove_star(recipe)
    Star.where(:user_id => self.id, :recipe_id => recipe.id).first.destroy
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def following
    ids = Relationship.where(:follower_id => self.id).select(:followed_id).map(&:followed_id)

    User.where("id IN (?)", ids).all
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
