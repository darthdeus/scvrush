# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    value 1
    association :reason
    association :user
  end

  factory :reason, :parent => :comment
end
