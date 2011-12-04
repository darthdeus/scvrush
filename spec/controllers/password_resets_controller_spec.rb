require 'spec_helper'

describe PasswordResetsController do
  describe "#create" do
    it "redirects user to signup_path when specified invalid url" do
      pending
      User.stub!(:find_by_username).and_return(nil)
      post :create
      flash[:notice].should contain("The user with given email doesn't exist")
    end
  end
end
