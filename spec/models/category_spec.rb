require 'spec_helper'

describe Category do
  it "should have a valid factory" do
    build(:category).should be_valid
  end
  
  it "should require a name" do
    Category.new.should_not be_valid
  end
  
  it "should require a unique name" do
    create(:category, :name => "foo")
    duplicate = build(:category, :name => "foo")
    duplicate.should_not be_valid    
    duplicate.should have(1).error_on(:name)
  end

end
