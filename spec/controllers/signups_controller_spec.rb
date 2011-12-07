require 'spec_helper'

describe SignupsController do
  specify :destroy do
    @user = mock_model(User)
    @user.should_receive(:has_bnet_username?).and_return(true)
    controller.stub!(:current_user).and_return(@user)

    @tournament = mock_model(Tournament)
    @tournament.stub!(:unregister)
    @tournament.should_receive(:unregister).with(@user)
    Tournament.should_receive(:find).with("1").and_return(@tournament)
    delete :destroy, id: 1
  end
end
