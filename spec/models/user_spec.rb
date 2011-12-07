require 'spec_helper'

describe User do
  it "has a valid factory" do
    build(:user).should be_valid
  end
  
  context "authentication" do
    it "with valid password" do
      user = create(:user, username: "batman", password: "secret")
      User.authenticate("batman", "secret").should == user
    end
    
    it "rejects bad password" do
      user = create(:user, username: "batman", password: "secret")
      User.authenticate("batman", "badpassword").should be_nil
    end
  end
  
  describe "#send_password_reset" do
    let(:user) { Factory(:user) }
    
    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)      
    end
    
    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end
    
    it "delivers email to the user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end    
  end
  
  describe "points" do    
    it "has no points when created" do
      build(:user).karma.should eq(0)
    end
  end
  
  describe "role" do
    it "defaults to subscriber" do
      build(:user).role.should == User::SUBSCRIBER
    end
  end
  
  describe "#checkin" do
    it "is CHECKED in" do
      signup = create(:signup)
      user = signup.user
      tournament = signup.tournament
      
      user.check_in(tournament)
      signup.reload
      signup.status.should == Signup::CHECKED            
    end
  end
  
  it "doesn't blow up when I call #send_password_reset" do
    @user = create(:user)
    lambda { @user.send_password_reset }.should_not raise_error
  end
  
  it "doesn't blow up when I call #save!" do
    @user = create(:user)
    lambda { @user.save! }.should_not raise_error    
  end
end
