require 'spec_helper'

describe "recipes/new" do
  before(:each) do
    assign(:recipe, stub_model(Recipe,
      :title => "MyString",
      :body => "MyText",
      :commit_message => "MyString",
      :revision => 1,
      :user => nil
    ).as_new_record)
  end

  it "renders new recipe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => recipes_path, :method => "post" do
      assert_select "input#recipe_title", :name => "recipe[title]"
      assert_select "textarea#recipe_body", :name => "recipe[body]"
      assert_select "input#recipe_commit_message", :name => "recipe[commit_message]"
      assert_select "input#recipe_revision", :name => "recipe[revision]"
      assert_select "input#recipe_user", :name => "recipe[user]"
    end
  end
end
