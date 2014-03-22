class Star < ActiveRecord::Base
  attr_accessible :recipe_id, :user_id

  set_primary_key :user_id

  belongs_to :recipe
  belongs_to :user
end
