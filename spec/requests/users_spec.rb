require 'spec_helper'

describe "Users" do
  describe "POST /users" do
    it "create user" do
      post_via_redirect users_path, :user => { :username => "foobar", :email => "foobar@example.com", :password => "secret", :password_confirmation => "secret"}
      response.body.should include("Signed up!")
    end        
  end
end
