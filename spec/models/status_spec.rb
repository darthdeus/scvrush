require "spec_helper"

describe Status do

  describe "#create_signup_for" do
    it "creates a new status for the user" do
      user = create(:user)
      signup = create(:signup, user: user)

      status = Status.create_for_signup(user, signup)

      user.reload
      user.should have(1).status
    end
  end
  
end
