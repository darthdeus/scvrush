require 'spec_helper'

describe ApiController do

  describe "GET 'auth'" do
    it "returns unauthorized for no params" do
      get :auth, format: 'json'
      response.status.should == 401
    end
  end

  describe "GET 'check'" do

    it "returns 200 if the API key exists" do
      User.stub!(:find_by_api_key) { true }
      get :check, format: 'json'
      response.status.should == 200
    end

    it "returns 401 for non-existing API key" do
      get :check, format: 'json', api_key: 'thereisnokeylikethisyo'
      response.status.should == 401
    end

  end

  describe "GET 'user_data'" do
    before(:all) do
      @user = create(:user)
      authenticator = UserAuthenticator.new(@user)
      authenticator.generate_api_key
      @user.save!
    end

    it "returns user's gravatar" do
      get :user_data, api_key: @user.api_key
      json = JSON.parse(response.body)
      json.should have_key("gravatar")
    end
  end

end
