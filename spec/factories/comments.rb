# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content "Lorem ipsum dolor sit amet"
    association :post
    association :user
  end
end
