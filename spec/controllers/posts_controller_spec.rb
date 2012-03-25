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
      unauthorized?
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
      post = create(:post)
      session[:user_id] = nil

      delete :destroy, :id => post.id
      unauthorized?
    end


    it "requires user to be administrator" do
      post = create(:post)
      login

      delete :destroy, :id => post.id
      unauthorized?
    end

    # it "sets the status to deleted instead of deleting the post"
  end

  describe "POST publish" do
    before { controller.stub!(:authorize!) }

    it "sets the post's published_at timestamp when sent properly" do
      p = create(:post)
      post :publish, id: p.id, published: 1, date: '2012-1-1', time: '14:30'
      response.should be_redirect

      flash[:notice].should match('Post was published')
      p.reload
      p.published_at.should == Time.parse('2012-1-1 14:30')
    end

    it "redirects back with error if the date format is invalid" do
      p = create(:post)
      post :publish, id: p.id, published: 1, date: 'a', time: 'a'
      response.should be_redirect

      flash[:error].should match('Invalid date or time format')
    end
  end

end
