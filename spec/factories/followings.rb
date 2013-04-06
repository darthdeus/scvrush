FactoryGirl.define do
  factory :following do
    association :follower, factory: :user
    association :followee, factory: :user
  end
end
