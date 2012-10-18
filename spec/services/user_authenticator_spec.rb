require "spec_helper"

describe UserAuthenticator do
  it "returns false for user" do
    UserAuthenticator.new(nil).authenticate("password").should be_false
  end

  it "authenticates user with a password" do
    user = create(:user, password: "password")
    authenticator = UserAuthenticator.new(user)

    result = User.authenticate(user.username, "password")
    authenticator.authenticate("password").should == result

    result = User.authenticate(user.username, "badpass")
    authenticator.authenticate("badpass").should == result
  end

end
