# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyString"
    text "MyText"
    category nil
  end
end
