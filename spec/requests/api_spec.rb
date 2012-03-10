require 'spec_helper'

describe "API" do

  it "generates new api key if user doesn't have one" do
    user = create(:user, password: 'secret')
    get "/api/auth.json", username: user.username, password: 'secret'
    response.status.should == 200

    user.reload
    user.api_key.should be_present
  end

  it "generates new api key if user doesn't have one" do
    user = create(:user, password: 'secret', api_key: 'random_junk')
    get "/api/auth.json", username: user.username, password: 'secret'
    response.status.should == 200

    user.reload
    user.api_key.should == 'random_junk'
  end

  it "returns 401 error if user is not authenticated" do
    user = create(:user, password: 'secret')
    get "/api/auth.json", username: user.username, password: 'badpass'
    response.status.should == 401
  end

  describe "#check" do
    it "authenticates API key" do
      user = create(:user, api_key: 'foobar')
      get "/api/check.json", api_key: 'foobar'
      response.status.should == 200
    end

    it "returns 401 on invalid API key" do
      user = create(:user, api_key: 'foobar')
      get "/api/check.json", api_key: 'badkey'
      response.status.should == 401
    end
  end

end
