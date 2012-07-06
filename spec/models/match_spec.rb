require "spec_helper"

describe Match do

  it "has a valid factory" do
    build(:match).should be_valid
  end

  it "requires bo for a match" do
    build(:match, bo: nil).should_not be_valid
  end

  it "is uncompleted by default" do
    build(:match).should_not be_completed
  end

  it "sets itself as completed if there are no players" do
    match = create(:match, player2: nil)
    match.should be_completed
  end

  it "sets itself as completed if player2 is not set" do
    match = create(:match, player2: nil)
    match.should be_completed
  end
end
