FactoryGirl.define do
  factory :recipe do
    title "Foo"
    body "##Bar"
    commit_message "Initial commit"
    revision 1
    slug "foo"
    tag_list "food"
    user
  end
end
