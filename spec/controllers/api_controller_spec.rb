require 'spec_helper'

describe ApiController do

  describe "GET 'auth'" do
    it "returns unauthorized for no params" do
      get :auth, format: 'json'
      response.status.should == 401
    end

    it "returns the API key if user is authorized" do
      user = stub(generate_api_key!: 'foobar', api_key: nil)
      User.stub!(:authenticate) { user }
      get :auth, format: 'json'
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

end
