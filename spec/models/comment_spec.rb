require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    build(:comment).should be_valid
  end
  
  it "requires post" do
    build(:comment, :post => nil).should have(1).error_on(:post)
  end
  
  it "requires user" do
    build(:comment, :user => nil).should have(1).error_on(:user)
  end
end
