FactoryGirl.define do
  factory :raffle_signup do
    association :user
    association :raffle    
  end
end
