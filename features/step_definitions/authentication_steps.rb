Given /^I am not logged in$/ do
  visit logout_path
end

Given /^I am logged in$/ do
  @user = FactoryGirl(:user, :password => 'secret')
  login(@user.username, 'secret')
end

Given /^I am an administrator$/ do
  @user = FactoryGirl(:user, :password => 'secret')
  @user.grant :admin
  login(@user.username, 'secret')
end

When /^I go to the dashboard page$/ do
  visit dashboard_path
end

Given /^I am a regular user$/ do
  step "I am logged in"
end

Then /^I should see "(\w+)"$/ do |text|
  page.should have_content(text)
end
