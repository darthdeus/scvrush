# Read about factories at http://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :topic do
    name "Sample topic"
    association :user
    association :section
  end
end
