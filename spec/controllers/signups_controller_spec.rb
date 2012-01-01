require 'spec_helper'

describe SignupsController do

  describe "stubbed" do
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

  describe "user signup" do
    before(:each) do
      Signup.destroy_all
      User.destroy_all
      Tournament.destroy_all
    end

    it "signs user up" do
      user       = create(:user)
      tournament = create(:tournament)
      controller.stub!(:current_user).and_return(user)

      post :create, :id => tournament.id

      signup = user.signups.first
      user.signups.size.should == 1
      signup.status.should == Signup::REGISTERED

      tournament.reload
      tournament.signups.should == [signup]
      tournament.users.should   == [user]
    end

    it "checks user in" do
      tournament = create(:tournament)
      user       = create(:user)
      controller.stub!(:current_user).and_return(user)

      post :create, :id => tournament.id
      signup = user.signups.first
      user.signups.size.should == 1
      signup.status.should == Signup::REGISTERED

      put :update, :id => tournament.id
      signup.reload
      signup.status.should == Signup::CHECKED

      tournament.reload
      tournament.signups.should include(signup)
      tournament.users.should   include(user)
    end
  end

end

