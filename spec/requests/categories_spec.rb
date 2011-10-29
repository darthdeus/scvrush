require 'spec_helper'

describe "Categories" do
  describe "POST /categories" do
    it "create category" do
      post categories_path, :category => { :name => "foo" }, :format => :js
      Category.last.name.should == "foo"
      response.status.should be(200)
    end

    it "supports js", :js => true do
      visit new_article_path
      fill_in "category_name", :with => "foobar"
      click_button "Add category"
      page.should have_content("foobar")
    end
    
    it "focuses category form when I click 'add new category'" do
      pending "http://stackoverflow.com/questions/7940525/testing-focus-with-capybara"
      visit new_article_path
      click_link "add new category"
      find_field("category_name").should have_focus
    end
  end
end
