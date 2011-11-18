require 'spec_helper'

describe Tagging do
  it "has a valid factory" do
    build(:tagging).should be_valid
  end
  
  it "requires post" do
    build(:tagging, :post => nil).should have(1).error_on(:post)
  end
  
  it "requires tag" do
    build(:tagging, :tag => nil).should have(1).error_on(:tag)
  end
end
