require 'spec_helper'

describe HomeHelper do
  describe "recipe_thumbnail_path" do
    it "returns first image path for recipes with uploaded images" do
      recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'first')
      recipe.recipe_images.create(:image => "fake_image")
      recipe_thumbnail_path(recipe).should_not == "/images/fork_knife.png"
    end

    it "returns default image path for recipes without uploaded images" do
      recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'first')
      recipe_thumbnail_path(recipe).should == "/images/fork_knife.png"
    end
  end
end
