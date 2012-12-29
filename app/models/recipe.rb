class Recipe < ActiveRecord::Base
  attr_accessible :body, :revision, :title, :user_id
end
