require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "should create an article for a user who is logged in" do      
      pending
      user = create(:user)      
      post sessions_path, :username => user.username, :password => user.password
      
      category = create(:category)

      post posts_path, :post => { :title => "lorem", :text => "ipsum", :category_id => category.id }
      response.should redirect_to(posts_path)
      
      follow_redirect!
      
      response.should render_template(:index)
      response.body.should include("published")
    end
  end
end
