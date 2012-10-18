require 'spec_helper'

describe Signup do

  context "validation" do
    it "requires a user" do
      build(:signup, user: nil).should_not be_valid
    end

    it "requires a tournament" do
      build(:signup, tournament: nil).should_not be_valid
    end

    it "has default value of REGISTERED" do
      create(:signup, status: nil).status == Signup::REGISTERED
    end
  end

  describe "#signup" do
    it "signs up the user with status REGISTERED" do
      tournament, user = create(:tournament), create(:user)
      signup = build(:signup, tournament: tournament, user: user)

      signup.signup!.should == true
      tournament.users.should include(user)
    end
  end

  describe "#checkin" do
    it "sets status to checked" do
      signup = create(:signup)
      signup.checkin!
      signup.status.should == Signup::CHECKED
    end
  end

  context "user profile" do
    it "adds a new status on user's profile when he signs up for a tournament"
  end

end
