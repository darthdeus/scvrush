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

  context "voting" do
    it "can count it's votes" do
      status = create(:status)
      status.votes_count.should == 0

      create(:vote, voteable: status)

      status.calculate_votes.reload
      status.votes_count.should == 1
    end
  end

end
