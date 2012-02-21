require 'spec_helper'

describe RaffleSignupsController do
  describe "#create" do
    it "should register a user and then redirect to the raffle" do
      controller.stub!(:current_user).and_return(:user)
      raffle = mock_model(Raffle)
      raffle.should_receive(:register).with(:user)
      Raffle.stub!(:find).and_return(raffle)
      post :create, :id => 1

      response.should redirect_to(raffle_path(raffle))
      flash[:notice].should_not be_empty
    end
  end

end
