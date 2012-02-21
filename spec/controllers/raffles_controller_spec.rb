require 'spec_helper'

describe RafflesController do
  describe "GET #new" do
    it "requres admin" do
      login
      get :new
      unauthorized?
    end

    it "allows admin" do
      login :admin
      get :new
      response.should be_success
    end
  end

  it "POST #create creates a new raffle" do
    login :admin
    post :create, raffle: { title: 'foobar', status: '0' }
    response.should redirect_to(Raffle.last)
  end
end