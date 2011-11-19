require 'spec_helper'

describe User do
  it "has a valid factory" do
    build(:user).should be_valid
  end
  
  context "authentication" do
    it "should authenticate with matching username and password" do
      user = create(:user, username: "batman", password: "secret")
      User.authenticate("batman", "secret").should == user
    end
    
    it "should authenticate with matching username and password" do
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
      build(:user).current_points.should eq(0)
    end
  end
end
