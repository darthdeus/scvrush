require 'spec_helper'

describe VotesController do

  describe "POST 'create'" do
    it "requires login" do
      session[:user_id] = nil
      post :create
      response.should redirect_to('/login')
    end

    it "doesn't allow user to vote on his own comment"
  end

  describe "DELETE 'destroy'" do
    it "allows user to delete his own vote"
    it "doesn't allow to delete vote owned by another user"
  end

end
