require 'spec_helper'

describe RecipeRevision do
  let(:revision) { FactoryGirl.create(:recipe_revision, revision: 1, recipe_id: 1) }
  describe "#previous" do
    let(:next_revision) { FactoryGirl.create(:recipe_revision, recipe_id: revision.recipe_id, revision: 2) }

    it "should return previous revision if it exists" do
      expect(next_revision.previous).to eq(revision)
    end

    it "should return nil if there is no previous revision" do
      expect(revision.previous).to eq(nil)
    end
  end
end
