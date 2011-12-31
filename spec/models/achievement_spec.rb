require 'spec_helper'

describe Achievement do
  it "has a valid factory" do
    build(:achievement).should be_valid
  end

  it "requires a name" do
    build(:achievement, :name => nil).should_not be_valid
  end

  it "sets a slug before it is created" do
    achievement = create(:achievement, :name => "Test")
    achievement.slug.should == "test"
  end

  it "has a dependent destroy"
end
