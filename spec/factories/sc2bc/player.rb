FactoryGirl.define do
  factory :player do
    sequence(:username) { |n| "john#{n}" }
    email { "#{username}@example.com" }
  end
end

