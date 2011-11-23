require 'spec_helper'

describe Post do
  it "should have a valid factory" do
    build(:post).should be_valid
  end
  
  it "requires title"
  it "requires content"
  it "is created as draft"
end
