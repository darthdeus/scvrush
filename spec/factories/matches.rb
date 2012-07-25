FactoryGirl.define do
  factory :match do
    sequence(:seed)
    association :player1, factory: :user
    association :player2, factory: :user
    association :round
  end
end
