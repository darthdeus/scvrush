require 'spec_helper'

describe SignupsController do

  before do
    @user = mock_model(User).as_null_object
    controller.stub!(:current_user).and_return(@user)
    @tournament = mock_model(Tournament)
    Tournament.stub!(:find).and_return(@tournament)
  end

  specify :create do
    @user.stub!(:sign_up)
    post :create, :id => 1
    response.should redirect_to(tournament_path(@tournament))
  end

  specify :destroy do
    @tournament.stub!(:unregister)
    delete :destroy, :id => 1
    response.should redirect_to(tournament_path(@tournament))
  end
end
