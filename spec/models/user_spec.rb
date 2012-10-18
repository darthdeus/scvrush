require 'spec_helper'

describe User do
  before { User.destroy_all }

  describe "#with_login" do
    let(:user) { create(:user) }

    it "finds a user by both username and email" do
      User.with_login(user.username).should == user
      User.with_login(user.email).should == user
    end
  end

  it "allows only alphanumeric characters in bnet_username" do
    build(:user, bnet_username: 'johndoe').should be_valid

    bad_user = build(:user, bnet_username: 'john@example.com')
    bad_user.should have_at_least(1).error_on(:bnet_username)
  end

  it "doesn't allow http in bnet_username" do
    bad_username = build(:user, bnet_username: 'http://google.com/')
    bad_username.should have_at_least(1).error_on(:bnet_username)
  end

  it "allows only numbers in bnet_code" do
    build(:user, bnet_code: 'foobar').should have_at_least(1).error_on(:bnet_code)
    build(:user, bnet_code:  123)    .should be_valid
    build(:user, bnet_code: '123')   .should be_valid
  end

  it "has a factory that allows to sign up for a tournament" do
    build(:user).should have_bnet_username
  end

  describe "#send_password_reset" do
    let(:user) { create(:user) }

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

  describe "#participating_in?" do
    it "returns true if user is participating in a raffle" do
      user   = create(:user)
      raffle = create(:raffle)
      create(:raffle_signup, user: user, raffle: raffle)

      user.participating_in?(raffle).should be_true
    end

    it "returns true if user is not participating in a raffle" do
      RaffleSignup.destroy_all
      user   = create(:user)
      raffle = create(:raffle)

      user.participating_in?(raffle).should be_false
    end
  end

  describe "#sign_up" do
    before(:each) { [User, Signup, Tournament].each(&:destroy_all) }

    it "creates a signup for a given user" do
      tournament = create(:tournament)
      user = create(:user)

      signup = user.sign_up(tournament)

      user.signups.should       == [signup]
      tournament.signups.should == [signup]
      tournament.users.should   == [user]
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

  describe :has_bnet_username? do
    it "returns false if the user has no info" do
      user = create(:user, bnet_username: nil)
      user.should_not have_bnet_username
    end
  end

  describe "#won_tournament!" do
    it "adds an achievement to the user" do
      user = create(:user)
      user.won_tournament!
      user.achievements.should have(1).item
      user.reload.achievements.should have(1).item
    end
  end

  describe "friendship" do
    it "means two users are friends if they are following each other" do
      u1 = create(:user)
      u2 = create(:user)

      u1.follow u2
      u2.follow u1

      u1.should be_friend(u2)
    end

  end
end
