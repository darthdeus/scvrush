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

  it "can serialize to JSON" do
    round = create(:round)
    p1 = create(:user, username: "player1")
    p2 = create(:user, username: "player2")
    p3 = create(:user, username: "player3")
    p4 = create(:user, username: "player4")

    round.matches << create(:match, player1: p1, player2: p2, round: round)
    round.matches << create(:match, player1: p3, player2: p4, round: round)

    round.to_simple_json.should == [
      { player1: "player1", player2: "player2" },
      { player1: "player3", player2: "player4" }
    ]
  end
end
