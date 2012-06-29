FactoryGirl.define do
  factory :round do
    association :tournament
    sequence(:number)
  end
end
