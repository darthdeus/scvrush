Given(/^I am not logged in$/) do
  visit logout_path
end

Given /^I am logged in$/ do
  @user = Factory(:user, :password => 'secret')
  login(@user.username, 'secret')
end

Given /^I am an administrator$/ do
  @user = Factory(:user, :password => 'secret', :role => User::ADMIN)
  login(@user.username, 'secret')
end

When /^I go to the dashboard page$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I am a regular user$/ do
  step "I am logged in"
end