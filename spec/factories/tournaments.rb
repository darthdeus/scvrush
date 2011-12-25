# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tournament do
    sequence(:name) { |n| "SCV Rush ##{n}" }
    starts_at { Time.now }
    association :post
  end
end
