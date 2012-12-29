class Recipe < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :commit_message, :revision, :title
end
