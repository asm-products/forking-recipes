class Event < ActiveRecord::Base
  # attr_accessible :user_id, :recipe_id, :action
  belongs_to :user
  belongs_to :recipe
end
