FactoryGirl.define do
  factory :status do
    text "Lorem ipsum dolor sit amet"
    association :user
    association :timeline, factory: :user
  end
end

