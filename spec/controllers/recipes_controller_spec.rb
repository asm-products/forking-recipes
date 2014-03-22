require 'spec_helper'

describe RecipesController do
  it "allows users to star recipes" do
    user   = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
    recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user)

    sign_in(user)

    post "star", :username => user.username, :recipe => recipe.slug

    user.starred_recipes.should == [recipe]
  end

  describe "#fork" do
    it "allows uers to fork a recipe" do
      user1   = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      user2   = User.create(:username => 'baz', :email => 'a@c.com', :password => 'password')
      recipe  = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user1)

      sign_in(user2)

      get :fork, :username => user1.username, :recipe => recipe.slug

      user2.recipes.last.forked_from_recipe_id.should == recipe.id
    end
  end
end
