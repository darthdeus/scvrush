require "spec_helper"

describe TournamentsController do

  context "creating user tournaments" do

    it "requires user to be logged in" do
      get :new
      response.should be_redirect
      flash[:error].should match("must be logged in")
    end

    it "doesn't allow unauthorized access" do
      user = login
      get :new
      response.should_not be_redirect
    end

    it "sets tournament user to the current user when created" do
      user = login
      post :create, tournament: Factory.attributes_for(:tournament)
      response.should be_redirect
      Tournament.last.user.should == user
    end

  end

end
