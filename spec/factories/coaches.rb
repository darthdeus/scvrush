# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coach do
    order 1
    title "MyString"
    post
  end
end
