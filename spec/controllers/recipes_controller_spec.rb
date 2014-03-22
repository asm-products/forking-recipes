require 'spec_helper'

describe RecipesController do
  it "allows users to star recipes" do
    user   = User.create!(:username => 'foo', :email => 'a@b.com', :password => 'password')
    recipe = Recipe.create!(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user)

    sign_in(user)

    post "star", :username => user.username, :recipe => recipe.slug

    user.starred_recipes.should == [recipe]
  end
end
