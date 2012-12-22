require "spec_helper"

describe TournamentsController do

  context "creating user tournaments" do

    # it "requires user to be logged in" do
    #   get :new
    #   response.should be_redirect
    #   flash[:error].should match("must be logged in")
    # end

    # it "doesn't allow unauthorized access" do
    #   user = login
    #   get :new
    #   response.should_not be_redirect
    # end

    # it "sets tournament user to the current user when created" do
    #   user = login
    #   post :create, tournament: FactoryGirl.attributes_for(:tournament)
    #   response.should be_redirect
    #   Tournament.last.user.should == user
    # end

  end

  context "editing a tournament" do
    context "as a tournament admin" do

      # let(:tournament) { create(:tournament, user: create(:user), starts_at: 1.minute.ago) }
      # before { login :tournament_admin }

      # it "can edit any tournament" do
      #   get :edit, id: tournament.id
      #   response.should be_ok
      # end

      # it "can update any tournament" do
      #   put :update, id: tournament.id, tournament: {}
      #   response.should redirect_to(tournament_path(tournament))
      # end

      # it "can seed any tournament" do
      #   post :seed, id: tournament.id
      #   response.should redirect_to(tournament)
      # end

      # it "can unseed any tournament" do
      #   post :unseed, id: tournament.id
      #   flash[:error].should be_nil
      #   response.should redirect_to(tournament)
      # end

      # it "can can start a tournament" do
      #   post :start, id: tournament.id
      #   response.should redirect_to(tournament)
      # end

    end
  end

end
