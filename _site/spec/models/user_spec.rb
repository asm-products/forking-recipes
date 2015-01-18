require 'spec_helper'

describe User do
  describe "starring" do
    it "allows a user to star a recipe" do
      recipe = FactoryGirl.create(:recipe)
      user   = FactoryGirl.create(:user)

      user.star(recipe)

      expect(user.starred_recipes).to eq([recipe])
    end

    it "allows users to remove stars" do
      recipe = FactoryGirl.create(:recipe)
      user   = FactoryGirl.create(:user)

      user.star(recipe)
      expect(user.starred_recipes).to eq([recipe])

      user.remove_star(recipe)
      expect(user.starred_recipes).to eq([])
    end
  end
end
