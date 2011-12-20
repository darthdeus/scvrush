# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    content 'Lorem ipsum dolor sit amet'
    association :topic
    association :user
  end
end
