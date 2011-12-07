FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foo#{n}"}
    password "secret"
    email { "#{username}@example.com"} 
    bnet_username { username }
    bnet_code 939
  end
end
