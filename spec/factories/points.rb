# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    value 1
    reason_type "MyString"
    reason_id 1
    user nil
    note "MyString"
  end
end
