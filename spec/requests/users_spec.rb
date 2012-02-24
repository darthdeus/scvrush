require 'spec_helper'

describe "Users" do
  describe "new user signup" do
    it "with corret information" do
      post_via_redirect users_path, :user => { :username => "foobar", :email => "foobar@example.com", :password => "secret", :password_confirmation => "secret"}
      response.body.should include("Signed up!")
    end
  end

  it "has a profile with information" do
    user = create(:user)
    visit user_path(user)
    page.should have_content(user.username)
  end
end
