require 'spec_helper'

describe "Articles" do
  describe "POST /articles" do    
    it "should create an article for a user who is logged in" do      
      user = create(:user)      
      post sessions_path, :username => user.username, :password => user.password
      
      category = create(:category)

      post articles_path, :article => { :title => "lorem", :text => "ipsum", :category_id => category.id }
      response.should redirect_to(articles_path)
      
      follow_redirect!
      
      response.should render_template(:index)
      response.body.should include("published")
    end
  end
end
