require 'spec_helper'

describe Post do
  it "should have a valid factory" do
    build(:post).should be_valid
  end
  
  it "should require unique title" do
    create(:post, title: "foo")
    duplicate = build(:post, title: "foo")
    duplicate.should_not be_valid
    duplicate.should have(1).error_on(:title)
  end
end
