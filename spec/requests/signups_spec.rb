require 'spec_helper'

describe "Signup" do
  before(:each) do
    [User, Tournament, Signup].each(&:destroy_all)

    @user = Factory(:user, :password => "secret")

    visit login_path

    fill_in "Username", :with => @user.username
    fill_in "Password", :with => "secret"
    click_button "Log in"

    within '.alert' do
      page.should have_content("You are now logged in")
    end
  end

  it "creates a new signup when tournament is open" do
    tournament = Factory(:tournament, :starts_at => 40.minutes.from_now)

    visit tournament_path(tournament)

    expect {
      click_button "Sign up for the tournament"
    }.not_to raise_exception

    page.should_not have_content("You must be logged in")

    current_path.should == tournament_path(tournament)

    signup = Signup.first

    tournament.reload
    tournament.signups.should == [signup]
  end

  it "checks the user in when he is already registered" do
    tournament = Factory(:tournament, :starts_at => 10.minutes.from_now)
    tournament.should be_checkin_open
    tournament.should_not be_signup_open

    @user.should have_bnet_username
    signup = @user.sign_up(tournament)

    @user.should be_registered_for(tournament)

    @user.reload
    visit tournament_path(tournament)
    click_button "Checkin!"

    current_path.should == tournament_path(tournament)

    within '.alert' do
      page.should have_content("You've been checked in! Enjoy the tournament.")
    end
  end


end