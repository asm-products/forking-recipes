require 'spec_helper'

describe RecipesController do
  it "allows users to star recipes" do
    user   = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
    recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user)

    sign_in(user)

    post "star", :user_id => user.username, :id => recipe.slug

    user.starred_recipes.should == [recipe]
  end

  describe "#fork" do
    it "allows uers to fork a recipe" do
      user1   = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      user2   = User.create(:username => 'baz', :email => 'a@c.com', :password => 'password')
      recipe  = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user1)

      sign_in(user2)

      get :fork, :user_id => user1.username, :id => recipe.slug

      user2.recipes.last.forked_from_recipe_id.should == recipe.id
    end
  end

  describe "#random" do
    it "redirects to a random recipe" do
      user   = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user)

      get "random"

      response.should redirect_to "/foo/recipes/foo"
    end
  end

  describe "#show" do
    it "doesn't blow up if the original recipe no longer exists" do
      user   = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      user2  = User.create(:username => 'baz', :email => 'a@c.com', :password => 'password')
      recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user)

      sign_in(user2)

      recipe.fork_to(user2)
      recipe.destroy

      get "show", :user_id => user2.username, :id => recipe.slug

      response.should be_success
    end
  end
end
