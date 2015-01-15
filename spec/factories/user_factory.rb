FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foo#{n}" }
    email { "#{username}@forkingrecipes.com" }
    password "secret"
  end
end
