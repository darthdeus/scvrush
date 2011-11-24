require 'spec_helper'

describe PostsController do
  describe "GET index" do
    it "loads only published posts"
  end
  
  describe "GET 'new'" do
    it "requires login" do
      get :new
      response.should redirect_to('/login')
    end
  end
      
  describe "POST 'create'" do
    it "requires login" do
      post :create
      response.should redirect_to('/login')      
    end
    
    it "requires user to have post rights" do
      user = create(:user, :role => User::SUBSCRIBER)
      session[:user_id] = user.id
      post :create
      response.should redirect_to('/')
      flash[:error].should match("Access denied")
    end
    it "creates new post belognging to the currently logged in user"
    it "validates the post"
  end
  
  describe "DELETE 'destroy'" do
    it "requires login" do
      session[:user_id] = nil      
      delete :destroy, :id => 1
      response.should redirect_to('/login')      
    end
    

    it "requires user to be administrator" do
      user = create(:user, :role => User::SUBSCRIBER)
      session[:user_id] = user.id

      delete :destroy, :id => 1
      response.should redirect_to('/')
      flash[:error].should match("Access denied")
    end

    it "sets the status to deleted instead of deleting the post"
  end
end
