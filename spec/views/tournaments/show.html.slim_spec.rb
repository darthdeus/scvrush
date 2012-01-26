require 'spec_helper'

describe "tournaments/show.html.slim" do
  before do
    assign(:registered_users, [])
    assign(:checked_users, [])
  end

  context "without users" do
    before { view.stub(:current_user).and_return(nil) }

    it "displays checkin button if checkin is open" do
      tournament = mock_model(Tournament, :checkin_open? => true, :name => "foo")
      assign(:tournament, tournament)

      render
      rendered.should include("Checkin!")
    end

    it "displays checkin button if checkin is open" do
      tournament = mock_model(Tournament, :checkin_open? => false,
                                          :name => "foo",
                                          :signup_open? => true)
      assign(:tournament, tournament)

      render
      rendered.should_not include("Checkin!")
      rendered.should include("Sign up for the tournament")
    end
  end

  context "user is registered" do
    it "displays cancel signup button" do
      user = mock_model(User, :registered_for? => true)
      view.stub(:current_user).and_return(user)

            tournament = mock_model(Tournament, :checkin_open? => false,
                                                :name => "foo",
                                                :signup_open? => true)
      assign(:tournament, tournament)

      render
      rendered.should include("Cancel your registration for the tournament")
    end

    it "displays signup button if not registered" do
      user = mock_model(User, :registered_for? => false)
      view.stub(:current_user).and_return(user)

            tournament = mock_model(Tournament, :checkin_open? => false,
                                                :name => "foo",
                                                :signup_open? => true)
      assign(:tournament, tournament)

      render
      rendered.should include("Sign up for the tournament")
    end
  end

end
