# Read about factories at http://github.com/thoughtbot/factory_girl

# TODO - https://gist.github.com/313121
# Implement a fixture file upload
FactoryGirl.define do
  factory :image do
    image { File.new(Rails.root + "spec/fixtures/logo.png") }
  end
end
