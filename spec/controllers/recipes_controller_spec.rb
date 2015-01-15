require 'spec_helper'

describe RecipesController do
  describe "#create" do
    it "creates a new recipe" do
      user = FactoryGirl.create(:user)
      sign_in(user)

      post :create, :recipe => {:title => "test title", :body => "foo", :commit_message => "first"}, :user_id => user.username

      recipe = user.recipes.first
      expect(recipe.title).to eq("test title")
      expect(recipe.body).to eq("foo")
    end

    it "rejects the create if title is blank" do
      user = FactoryGirl.create(:user)
      sign_in(user)

      post :create, :recipe => {:title => "", :body => "foo", :commit_message => "first"}, :user_id => user.username

      expect(response).to render_template(:new)
    end

    it "rejects the create if commit message is blank" do
      user = FactoryGirl.create(:user)
      sign_in(user)

      post :create, :recipe => {:title => "title", :body => "foo", :commit_message => ""}, :user_id => user.username

      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    it "allows users to update the body of a recipe and redirects to #show" do
      user   = FactoryGirl.create(:user)
      recipe = FactoryGirl.create(:recipe, :user => user)
      sign_in(user)

      post :update, :recipe => {:title => "foo", :body => "bat", :commit_message => "next"}, :user_id => user.username, :id => recipe.slug

      recipe.reload
      expect(recipe.body).to eq("bat")
      expect(recipe.commit_message).to eq("next")
      expect(response).to redirect_to([user, recipe])
    end
  end

  it "allows users to star recipes" do
    user   = FactoryGirl.create(:user)
    recipe = FactoryGirl.create(:recipe, :user => user)
    sign_in(user)

    post :star, :user_id => user.username, :id => recipe.slug

    expect(user.starred_recipes).to eq([recipe])
  end

  describe "#fork" do
    it "allows uers to fork a recipe" do
      user1  = FactoryGirl.create(:user)
      user2  = FactoryGirl.create(:user)
      recipe = FactoryGirl.create(:recipe, :user => user1)
      sign_in(user2)

      get :fork, :user_id => user1.username, :id => recipe.slug

      expect(user2.recipes.last.forked_from_recipe_id).to eq(recipe.id)
    end
  end

  describe "#random" do
    it "redirects to a random recipe" do
      recipe = FactoryGirl.create(:recipe)

      get :random

      expect(response).to redirect_to([recipe.user, recipe])
    end
  end

  describe "#show" do
    it "doesn't blow up if the original recipe no longer exists" do
      user1  = FactoryGirl.create(:user)
      user2  = FactoryGirl.create(:user)
      recipe = FactoryGirl.create(:recipe, :user => user1)
      sign_in(user2)

      recipe.fork_to(user2)
      recipe.destroy

      get :show, :user_id => user2.username, :id => recipe.slug

      expect(response).to be_success
    end
  end
end
