require 'spec_helper'

describe Recipe do
  describe "#number_of_stars" do
    it "returns 0 if the recipe hasn't been starred" do
      recipe = FactoryGirl.create(:recipe)

      expect(recipe.number_of_stars).to eq(0)
    end

    it "returns the number of times the recipe has been starred" do
      recipe = FactoryGirl.create(:recipe)
      recipe.user.star(recipe)

      expect(recipe.number_of_stars).to eq(1)
    end
  end

  describe "#number of forks" do
    it "returns 0 if there are no forks" do
      recipe = FactoryGirl.create(:recipe)

      expect(recipe.number_of_forks).to eq(0)
    end

    it "returns the number of forks this recipe has" do
      recipe = FactoryGirl.create(:recipe)
      FactoryGirl.create(:recipe, :forked_from_recipe_id => recipe.id)

      expect(recipe.number_of_forks).to eq(1)
    end
  end
end
