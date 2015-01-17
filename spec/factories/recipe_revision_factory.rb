FactoryGirl.define do
  factory :recipe_revision do
    body "Foo"
    commit_message "Foo commit"
    revision 2
    title "Foo title"
  end
end
