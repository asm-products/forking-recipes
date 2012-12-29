require 'spec_helper'

describe "recipes/edit" do
  before(:each) do
    @recipe = assign(:recipe, stub_model(Recipe,
      :title => "MyString",
      :body => "MyText",
      :commit_message => "MyString",
      :revision => 1,
      :user => nil
    ))
  end

  it "renders the edit recipe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recipes_path(@recipe), :method => "post" do
      assert_select "input#recipe_title", :name => "recipe[title]"
      assert_select "textarea#recipe_body", :name => "recipe[body]"
      assert_select "input#recipe_commit_message", :name => "recipe[commit_message]"
      assert_select "input#recipe_revision", :name => "recipe[revision]"
      assert_select "input#recipe_user", :name => "recipe[user]"
    end
  end
end
