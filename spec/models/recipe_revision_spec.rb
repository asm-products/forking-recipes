require 'spec_helper'

describe RecipeRevision do
  describe "#previous" do
    it "should return previous revision if it exists" do
      revision = FactoryGirl.create(:recipe_revision, revision: 1, recipe_id: 1)
      next_revision = FactoryGirl.create(:recipe_revision, recipe_id: revision.recipe_id, revision: 2)

      expect(next_revision.previous).to eq(revision)
    end

    it "should return nil if there is no previous revision" do
      revision = FactoryGirl.create(:recipe_revision, revision: 1, recipe_id: 1)
      next_revision = FactoryGirl.create(:recipe_revision, recipe_id: revision.recipe_id, revision: 2)

      expect(revision.previous).to eq(nil)
    end
  end
end
