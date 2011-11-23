# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :signup do
    status 0
    placement 0
    association :user
    association :tournament
  end
end
