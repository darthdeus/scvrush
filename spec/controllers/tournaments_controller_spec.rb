require 'spec_helper'

describe TournamentsController do

  describe "#show" do
    it "renders signup page if the tournament hasn't started yet" do
      tournament = create(:tournament)
      tournament.stub(:started) { true }
      TournamentDecorator.stub(:find) { tournament }

      get :show, id: 1
      response.should render_template(:signup)
    end

    it "renders doesn't render signup page if the tournament has started" do
      tournament = create(:tournament)
      tournament.stub(:started) { true }

      TournamentDecorator.stub(:find) { tournament }

      get :show, id: 1
      response.should render_template(:show)
    end
  end

end
