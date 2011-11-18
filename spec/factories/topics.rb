# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    name "MyString"
    section nil
    user nil
  end
end
