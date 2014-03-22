require 'spec_helper'

describe Recipe do
  describe "#number_of_stars" do
    it "returns 0 if the recipe hasn't been starred" do
      recipe = Recipe.create(:title => 'foo', :body => 'blah', :commit_message => 'first')

      recipe.number_of_stars.should == 0
    end

    it "returns the number of times the recipe has been starred" do
      user   = User.create(:username => 'foo', :password => 'password', :email => 'a@b.com')
      recipe = Recipe.create(:title => 'foo', :body => 'blah', :commit_message => 'first', :user => user)

      user.star(recipe)

      recipe.number_of_stars.should == 1
    end
  end

  describe "#number of forks" do
    it "returns 0 if there are no forks" do
      recipe = Recipe.create(:title => 'foo', :body => 'blah', :commit_message => 'first')

      recipe.number_of_forks.should == 0
    end

    it "returns the number of forks this recipe has" do
      id = Recipe.create(:title => 'foo', :body => 'blah', :commit_message => 'first').id
      recipe = Recipe.create(:title => 'foo',
                             :body => 'blah',
                             :commit_message => 'first',
                             :forked_from_recipe_id => id)

      recipe.number_of_forks.should == 1
    end
  end
end
