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

  describe "score" do
    it "sets score in proper order" do
      p1, p2 = create(:user), create(:user)
      m = build(:match, player1_id: p1, player2_id: p2)
      m.set_score_for(p1, "1:3")
      m.score.should == "1:3"

      m.set_score_for(p2, "1:3")
      m.score.should == "3:1"
    end

    it "returns score for each player properly" do
      p1, p2 = create(:user), create(:user)
      m = build(:match, player1_id: p1, player2_id: p2)
      m.set_score_for(p1, "1:3")

      m.score_for(:player1).should == 1
      m.score_for(:player2).should == 3
    end
  end
end
