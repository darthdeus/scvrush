Given /^I have (\d+) tournaments$/ do |number|
  number.to_i.times { Factory(:tournament) }
end

When /^I select a tournament in the upcoming section$/ do
  @tournament = Tournament.last
end

Then /^it should be shown on the main page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the last tournament in the list$/ do
  within('#upcoming') do
    page.should have_content(Tournament.last.name)
  end
end

