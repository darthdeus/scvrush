require 'spec_helper'

describe PostsController do
  describe "GET index" do
    it "loads only published posts" do
      post  = create(:post, status: Post::PUBLISHED)
      draft = create(:post, status: Post::DRAFT)

      get :index
      assigns[:posts].should == [post]
    end
  end

  describe "GET 'new'" do
    it "requires login" do
      get :new
      response.should redirect_to('/')
    end

    it "requires writer" do
      login
      get :new
      unauthorized?
    end

    it "allows user to create a post if he is a writer" do
      login :writer
      get :new
      response.should_not be_redirect
    end

  end

  describe "POST 'create'" do
    it "requires login" do
      post :create
      response.should redirect_to('/login')
    end

    it "requires user to have post rights" do
      login
      post :create
      unauthorized?
    end

    it "allows user to create a post if he is a writer" do
      login :writer
      post :create
      response.should_not be_redirect
    end


    # it "creates new post belognging to the currently logged in user"
    # it "validates the post"
  end

  describe "DELETE 'destroy'" do
    it "requires login" do
      session[:user_id] = nil
      delete :destroy, :id => 1
      response.should redirect_to('/login')
    end


    it "requires user to be administrator" do
      user = create(:user)
      session[:user_id] = user.id

      delete :destroy, :id => 1
      response.should redirect_to('/')
      flash[:error].should match("Access denied")
    end

    # it "sets the status to deleted instead of deleting the post"
  end
end
