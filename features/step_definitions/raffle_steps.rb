Given /^I have an open raffle$/ do
  @raffle = Factory(:raffle, status: Raffle::OPEN)
end

Given /^the raffle has a user registered$/ do
  @user = Factory(:user)
  @raffle.register(@user)
end

Given /^I have a closed raffle$/ do
  @raffle = Factory(:raffle, status: Raffle::FINISHED)
end

When /^I go to that raffle page$/ do
  visit raffle_path(@raffle)
end

Then /^I should be able to join$/ do
  lambda { find_button("Join the raffle!") }.should_not raise_error(Capybara::ElementNotFound)
end

Then /^I should not be able to join$/ do
  lambda { find_button("Join the raffle!") }.should raise_error(Capybara::ElementNotFound)
end

When /^I close the raffle$/ do
  @winner = @raffle.calculate_winner
end

Then /^a winner should be selected$/ do
  visit raffle_path(@raffle)
  page.should have_content("The winner is")
end

