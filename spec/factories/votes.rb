FactoryGirl.define do
  factory :vote do
    association :user
    value 1
    association :voteable, factory: :status
  end
end

