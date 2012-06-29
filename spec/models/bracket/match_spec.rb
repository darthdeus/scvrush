require "spec_helper"

describe Match do

  it "has a valid factory" do
    build(:match).should be_valid
  end

  it "requires bo for a match" do
    build(:match, bo: nil).should_not be_valid
  end

end
