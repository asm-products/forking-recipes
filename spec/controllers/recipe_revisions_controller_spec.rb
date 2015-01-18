require 'spec_helper'

describe RecipeRevisionsController do

  describe 'GET show' do
    it "should assign previous revision if target_id is not present" do
      recipe = FactoryGirl.create(:recipe)
      user = recipe.user
      recipe_revision = FactoryGirl.create(:recipe_revision, revision: 2, user_id: user.id, recipe_id: recipe.id)
      recipe_revision2 = FactoryGirl.create(:recipe_revision, revision: 1, user_id: user.id, recipe_id: recipe.id)

      get :show, {recipe_id: recipe.to_param, user_id: user.to_param, id: recipe_revision.to_param}
      expect(assigns(:revision)).to eq(recipe_revision)
      expect(assigns(:target_revision)).to eq(previous_revision)
      expect(assigns(:diff)).to eq(Differ.diff_by_line(recipe_revision.body, recipe_revision2.body).format_as(:html).html_safe)
    end

    it "should assign target_revision if target_id is present" do
      recipe = FactoryGirl.create(:recipe)
      user = recipe.user
      recipe_revision = FactoryGirl.create(:recipe_revision, revision: 2, user_id: user.id, recipe_id: recipe.id)
      user2 = recipe2.user
      recipe2 = FactoryGirl.create(:recipe)
      recipe_revision2 = FactoryGirl.create(:recipe_revision, user_id: user2.id, recipe_id: recipe2.id)

      get :show, {recipe_id: recipe.to_param, user_id: user.to_param, id: recipe_revision.to_param, target_id: recipe_revision2.to_param}
      expect(assigns(:revision)).to eq(recipe_revision)
      expect(assigns(:target_revision)).to eq(recipe_revision2)
      expect(assigns(:diff)).to eq(Differ.diff_by_line(recipe_revision.body, recipe_revision2.body).format_as(:html).html_safe)
    end
  end
end
