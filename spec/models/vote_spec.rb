require "spec_helper"

describe Vote do

  it "has a valid factory" do
    build(:vote).should be_valid
  end

  it "requires a user" do
    build(:vote, user: nil).should_not be_valid
  end

end
