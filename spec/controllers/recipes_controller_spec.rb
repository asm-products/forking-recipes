require 'spec_helper'

describe RecipesController do
  describe "#create" do
    it "creates a new recipe" do
      user = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      sign_in(user)

      post "create", :recipe => {:title => 'test title', :body => 'foo', :commit_message => 'first'}, :user_id => user.username

      r = user.recipes.first

      r.title.should == 'test title'
      r.body.should  == 'foo'
    end

    it "rejects the create if title is blank" do
      user = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      sign_in(user)

      put "create", :recipe => {:title => '', :body => 'foo', :commit_message => 'first'}, :user_id => user.username

      expect(response).to render_template(:new)
    end

    it "rejects the create if commit message is blank" do
      user = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      sign_in(user)

      put "create", :recipe => {:title => 'title', :body => 'foo', :commit_message => ''}, :user_id => user.username

      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    it "allows users to update the body of a recipe" do
      user = User.create(:username => 'foo', :email => 'a@b.com', :password => 'password')
      recipe = Recipe.create(:title => 'foo', :body => 'bar', :commit_message => 'foo', :slug => 'foo', :user => user, :revision => 1)

      sign_in(user)

      post "update", :recipe => {:title => 'foo', :body => 'bat', :commit_message => 'next'}, :user_id => user.username, :id => recipe.slug

      recipe.reload.body.should == 'bat'
    end
  end

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

  describe "#update" do
    it "updates recipe and redirects to #show" do
      user = User.create(:email => "test@example.com", :username => "test", :password => "secret")
      recipe = Recipe.create(:title => "foo", :body => "blah", :commit_message => "first", :slug => "foo", :revision => 1, :user => user)

      sign_in(user)

      put "update", :user_id => user.username, :id => recipe.slug,
        :recipe => {:title => "foo", :body => "new blah", :commit_message => "second"}

      recipe.reload
      recipe.body.should == "new blah"
      response.should redirect_to([user, recipe])
    end
  end
end
