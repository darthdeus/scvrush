require 'spec_helper'

describe PasswordResetsController do
  describe "#create" do
    it "redirects user to signup_path when specified invalid url" do
      User.should_receive(:find_by_email).with("invalid@example.com").and_return(nil)
      post :create, :email => "invalid@example.com"
      response.should redirect_to(signup_path)
      flash[:notice].should match("The user with given email doesn't exist")
    end
  end
end
