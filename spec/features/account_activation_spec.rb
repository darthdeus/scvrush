require "spec_helper"

describe "Account activation", js: true do

  it "shows activate button on the home page" do
    visit "/"
    click_link "Activate your account"
    page.should have_content("You currently have a trial account")

    within "#account-activation" do
      find(".password").set("secret")
      find(".password_confirmation").set("secret")
    end

    click_button "Activate the account"
    page.should have_content("Welcome to SCV Rush")
    page.should_not have_content("Activate your account")
  end

end
