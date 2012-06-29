require "spec_helper"

describe Round do

  it "has a valid factory" do
    build(:round).should be_valid
  end

  it "requires number for a round" do
    build(:round, number: nil).should_not be_valid
  end

  it "requires a tournament" do
    build(:round, tournament: nil).should_not be_valid
  end
end
