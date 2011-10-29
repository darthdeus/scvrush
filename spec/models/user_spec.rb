require 'spec_helper'

describe User do
  it "should have a valid factory" do
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
end
