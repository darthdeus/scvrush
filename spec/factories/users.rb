# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foo#{n}"}
    password "foobar"
    email { "#{username}@example.com"} 
    bnet_username { username }
    bnet_code 939
  end
end
