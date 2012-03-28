require 'spec_helper'

describe VotesController do

  describe "POST 'create'" do
    it "requires login" do
      session[:user_id] = nil
      post :create
      response.should redirect_to('/login')
    end

    it "doesn't allow user to vote on his own comment" do
      user = login
      comment = create(:comment, user_id: user.id)

      comment.votes_for.should == 0
      post :create, id: comment.id
      comment.votes_for.should == 0
    end

  end

  describe "DELETE 'destroy'" do

    it "allows user to delete his own vote" do
      user = login
      comment = create(:comment)
      user.vote_for(comment)

      user.should_receive(:clear_votes).with(comment)
      controller.stub(:current_user) { user }

      delete :destroy, id: comment.id
    end

  end

end
