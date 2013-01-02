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
end
