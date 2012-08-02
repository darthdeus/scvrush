require "spec_helper"

describe Match do

  it "has a valid factory" do
    build(:match).should be_valid
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

  describe "can_submit?" do

    it "allows to sumbit if ther eis no winner and both players" do
      build(:match).can_submit?.should == true
    end

    it "can't submit if there is a winner" do
      m = create(:match)
      m.set_score_for(m.player1, "1:0")
      m.can_submit?.should == false
    end

    it "can't submit if there is only one player" do
      build(:match, player1: nil).can_submit?.should == false
      build(:match, player2: nil).can_submit?.should == false
    end
  end

  describe "score" do
    it "requires a proper format" do
      build(:match, score: "foo").should have_at_least(1).error_on(:score)
      build(:match, score: "0:0").should have_at_least(1).error_on(:score)
      build(:match, score: "1:0").should be_valid
    end

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

      m.set_score_for(p2, "1:3")

      m.score_for(:player1).should == 3
      m.score_for(:player2).should == 1
    end

    it "returns a match winner" do
      p1, p2 = create(:user), create(:user)
      m = create(:match, player1: p1, player2: p2)

      m.winner.should be_nil

      m.set_score_for(p1, "1:3")
      m.save!

      m.score_for(:player1).should == 1
      m.score_for(:player2).should == 3
      m.reload
      m.winner.should == p2

      # Let's try this in reverse
      m.set_score_for(p2, "1:3")
      m.save!

      m.score_for(:player1).should == 3
      m.score_for(:player2).should == 1
      m.reload
      m.winner.should == p1
    end
  end

  describe "next" do
    it "can tell what the next match is" do
      ro4 = create(:round)
      2.times { ro4.matches << create(:match) }

      ro2 = create(:round, parent: ro4)
      last_match = create(:match)
      ro2.matches << last_match

      ro4.matches.first.next.should == last_match
    end
  end
end
