require 'spec_helper'

describe "Comments" do
  describe "create" do
    it "should create a comment for a given logged in user" do
      pending "finish after login request specs are working"
      user = Factory(:user, :username => "johndoe", :password => "foobar")
      p User.first
      visit login_path
      fill_in :username, :with => "johndoe"
      fill_in :password, :with => "foobar"
      click_button "Log in"
      
      

      page.should have_content("You've been logged in")      
    end
  end
end
