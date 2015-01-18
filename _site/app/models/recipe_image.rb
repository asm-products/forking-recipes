class RecipeImage < ActiveRecord::Base
  # attr_accessible :image, :recipe, :recipes_id
  include CarrierWave::RMagick

  belongs_to :recipe

  mount_uploader :image, ImageUploader
end
