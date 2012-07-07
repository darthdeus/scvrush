FactoryGirl.define do
  factory :match do
    bo 3
    score "1:3"
    sequence(:seed)
    association :player1, factory: :user
    association :player2, factory: :user
    association :round
  end
end
