require 'spec_helper'

describe Tag do
  it "has a valid factory" do
    build(:tag).should be_valid
  end
  
  it "requires name" do
    tag = build(:tag, :name => nil)
    tag.should_not be_valid
    tag.should have(1).error_on(:name)
  end
end
