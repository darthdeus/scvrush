require 'spec_helper'

describe User do
  before { User.destroy_all }

  it "has a valid factory" do
    build(:user).should be_valid
  end

  context "authentication" do
    it "with valid password" do
      user = create(:user, username: "batman", password: "secret")
      User.authenticate("batman", "secret").should == user
    end

    it "rejects bad password" do
      user = create(:user, username: "batman", password: "secret")
      User.authenticate("batman", "badpassword").should be_nil
    end
  end

  describe "#send_password_reset" do
    let(:user) { Factory(:user) }

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to the user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end
  end

  describe "points" do
    it "has no points when created" do
      build(:user).karma.should eq(0)
    end
  end

  describe "role" do
    it "defaults to subscriber" do
      build(:user).role.should == User::SUBSCRIBER
    end
  end

  it "doesn't blow up when I call #send_password_reset" do
    @user = create(:user)
    lambda { @user.send_password_reset }.should_not raise_error
  end

  describe "#participating_in?" do
    it "returns true if user is participating in a raffle" do
      @user = create(:user)
      @raffle = create(:raffle)
      create(:raffle_signup, user: @user, raffle: @raffle)

      @user.participating_in?(@raffle).should be_true
    end

    it "returns true if user is not participating in a raffle" do
      RaffleSignup.destroy_all
      @user = create(:user)
      @raffle = create(:raffle)

      @user.participating_in?(@raffle).should be_false
    end
  end

  describe "#sign_up" do
    before(:each) { [User, Signup, Tournament].each(&:destroy_all) }

    it "creates a signup for a given user" do
      user = create(:user)
      tournament = create(:tournament)

      signup = user.sign_up(tournament)
      user.signups.should == [signup]
    end

    it "adds the user to the tournament's list" do
      user = create(:user)
      tournament = create(:tournament)

      user.should_not be_registered_for(tournament)
      user.sign_up(tournament)
      tournament.users.should == [user]
      user.should be_registered_for(tournament)
    end
  end

  describe "#check_in" do
    it "is CHECKED in" do
      user = create(:user)
      tournament = create(:tournament)

      user.sign_up(tournament)

      user.signups.size.should == 1
      signup = user.signups.first

      expect {
        user.check_in(tournament)
        signup.reload
      }.to change { signup.status }.from(Signup::REGISTERED).to(Signup::CHECKED)
    end

    it "raises and exception if user isn't signed up" do
      user = create(:user)
      tournament = create(:tournament)
      expect {
        user.check_in(tournament)
      }.to raise_exception(NotRegistered)
    end
  end

  describe "#won_tournament!" do
    it "adds an achievement to the user" do
      user = create(:user)
      user.won_tournament!
      user.achievements.size.should == 1
    end

    it "it doesn't add the achievement if the user already has it" do
      Achievement.destroy_all
      UserAchievement.destroy_all
      User.destroy_all

      user = create(:user)
      user.won_tournament!
      user.won_tournament!
      user.achievements.size.should == 1
    end
  end
end
