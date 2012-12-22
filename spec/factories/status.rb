FactoryGirl.define do
  factory :status do
    text "Lorem ipsum dolor sit amet"
    association :user
  end
end

