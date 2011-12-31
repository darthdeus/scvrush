# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_achievement do
    association :user
    association :achievement
  end
end
