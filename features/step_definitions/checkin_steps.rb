Given /^I have a post$/ do
  @post = Factory(:post)
end

Given /^I have a comment on that post$/ do
  @comment = Factory(:comment, post: @post)
end

Given /^I am on the post page$/ do
  visit post_path(@post)
end

Given /^I have a tournament starting in (\d+) (\w+)$/ do |n, rate|
  @tournament = Factory(:tournament, starts_at: n.to_i.send(rate).from_now)
end

Given /^I am on that tournament page$/ do
  visit tournament_path(@tournament)
end

Given /^I am signed up$/ do
  step "I am logged in"
  @user.sign_up(@tournament)
end

When /^I go to that tournament page$/ do
  visit tournament_path(@tournament)
end

Then /^I should not be able to check in$/ do
  lambda { find_button("Checkin!") }.should raise_error(Capybara::ElementNotFound)
end

Then /^I should be able to check in$/ do
  click_button "Checkin!"
end

Then /^I should not be able to sign up$/ do
  lambda { find_button("Sign up") }.should raise_error(Capybara::ElementNotFound)
end

Then /^I should be able to sign up$/ do
  click_button "Sign up"
end

When /^I check in$/ do
  click_button "Checkin!"
end

Then /^I should be in the checkin list$/ do  
  within ".alert-message" do
    page.should have_content("You've been checked in! Enjoy the tournament.")
  end
  @tournament.signups.checked.should == [@user.signups.last]
end
