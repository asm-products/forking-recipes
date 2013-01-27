class RecipeImage < ActiveRecord::Base
  include CarrierWave::RMagick

  attr_accessible :image, :recipe
  belongs_to :recipe

  mount_uploader :image, ImageUploader
end
