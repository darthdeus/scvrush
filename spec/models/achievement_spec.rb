require 'spec_helper'

describe Achievement do
  it "has a valid factory" do
    build(:achievement).should be_valid
  end

  it "requires a name" do
    build(:achievement, :name => nil).should_not be_valik
  end

  it "has a dependent destroy"
end
