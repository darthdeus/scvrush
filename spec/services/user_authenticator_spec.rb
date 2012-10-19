require "spec_helper"

describe UserAuthenticator do
  it "returns false for user" do
    UserAuthenticator.new(nil).authenticate("password").should be_false
  end

  it "authenticates user with a password" do
    user = create(:user, password: "password")
    authenticator = UserAuthenticator.new(user)

    authenticator.authenticate("password").should == user
    authenticator.authenticate("badpass").should == nil
  end

end
