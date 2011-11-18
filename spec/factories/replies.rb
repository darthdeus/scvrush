# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    content "MyText"
    topic nil
    user nil
  end
end
