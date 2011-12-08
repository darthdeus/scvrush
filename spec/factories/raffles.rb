# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :raffle do
    status 0
    association :winner
    title "MyString"
  end
  
  factory :winner, :parent => :user
end
