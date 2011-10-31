require 'spec_helper'

describe "Articles" do
  describe "POST /articles" do
    it "should require logged in user" do
      # get '/log_out'      
      # category_id = create(:category, name: "lipsum").id
      
      post '/articles'
      page.should have_content "You have to be logged in"
    end
    
    it "should create an article" do
      create(:category, name: "lipsum")
      visit new_article_path
      fill_in "Title", :with => "Lorem Ipsum"
      fill_in "Text", :with => "Lorem ipsum dolor sit amet"
      select "lipsum", :from => "article_category_id"
      click_button "Publish"
      page.should have_content("Article published")
    end
  end
end
