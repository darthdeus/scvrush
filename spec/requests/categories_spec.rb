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
  end
end
