# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "Lorem ipsum"
    text "Lorem ipsum dolor sit amet"
    association :category
  end
end
