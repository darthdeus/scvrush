require 'spec_helper'

describe Article do
  it "should have a valid factory" do
    build(:article).should be_valid
  end
  
  it "should require unique title" do
    create(:article, title: "foo")
    duplicate = build(:article, title: "foo")
    duplicate.should_not be_valid
    duplicate.should have(1).error_on(:title)
  end
  
  it "should have a category when created" do
    article = create(:article)
    article.category.should_not be_nil
  end
end
