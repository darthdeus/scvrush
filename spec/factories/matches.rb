FactoryGirl.define do
  factory :match do
    bo 3
    association :player1, factory: :user
    association :player2, factory: :user
    association :round
  end
end
