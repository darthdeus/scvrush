require 'spec_helper'

describe PostsController do

  describe "GET 'index'" do
  end

  describe "GET 'new'" do
    it "should require login" do
      get :new
      response.should redirect_to('/login')      
    end
  end
  
  describe "POST 'create'" do
    it "should require login" do
      post :create
      response.should redirect_to('/login')      
    end
  end

  describe "DELETE 'destroy'" do
    it "should require login" do
      delete :destroy, :id => 1
      response.should redirect_to('/login')      
    end
  end


end
