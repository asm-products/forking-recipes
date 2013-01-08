class User < ActiveRecord::Base
  validates :username, :uniqueness => true
  validates_format_of :username, :with => /^[a-zA-Z0-9_]*$/, :on => :create

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :events

  has_many :followed_users, :through => :relationships, :source => :followed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def following
    ids = Relationship.where(:follower_id => self.id).select(:followed_id).map(&:followed_id)

    User.find_all_by_id(ids)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
