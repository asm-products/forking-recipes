require 'spec_helper'

describe Recipe do
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
