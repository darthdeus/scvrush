require 'spec_helper'

describe PostsController do

  describe "GET 'index'" do
    it "doesn't show posts that are saved as drafts"
    it "returns list of published posts"
  end

  describe "GET 'new'" do
    it "should require login" do
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
      user = create(:user, :role => :subscriber)
      session[:user_id] = user_id
      post :create      
      response.should redirect_to('/')
      response.body.should contain("You don't have the rights to post")
    end
    it "creates new post belognging to the currently logged in user"
    it "validates the post"
  end

  describe "DELETE 'destroy'" do
    it "requires login" do
      delete :destroy, :id => 1
      response.should redirect_to('/login')      
    end

    it "requires user to be administrator" do
      user = create(:user, :role => :subscriber)
      session[:user_id] = user_id
      delete :destroy      
      response.should redirect_to('/')
      response.body.should contain("You don't have the rights to delete a post")      
    end
    
    it "sets the status to deleted instead of deleting the post"
  end


end
