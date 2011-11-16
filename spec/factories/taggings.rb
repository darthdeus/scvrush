# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tagging do
    association :tag
    association :post
  end
end
