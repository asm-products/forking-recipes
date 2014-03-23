require 'spec_helper'

describe User do
  describe "starring" do
    it "allows a user to star a recipe" do
      recipe = Recipe.create(:title => 'foo', :body => 'baz', :commit_message => 'first')
      user   = User.create!(:username => 'foo', :email => 'foo@bar.com', :password => 'password')

      user.star(recipe)

      user.starred_recipes.should == [recipe]
    end

    it "allows users to remove stars" do
      recipe = Recipe.create(:title => 'foo', :body => 'baz', :commit_message => 'first')
      user   = User.create!(:username => 'foo', :email => 'foo@bar.com', :password => 'password')

      user.star(recipe)
      user.starred_recipes.should == [recipe]

      user.remove_star(recipe)
      user.starred_recipes.should == []
    end
  end
end
