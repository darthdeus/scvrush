require "spec_helper"

describe Match do

  before { User.delete_all }

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
      m = build(:match, player1_id: p1.id, player2_id: p2.id)
      m.set_score_for(p1, "1:3")
      m.score.should == "1:3"

      m.set_score_for(p2, "1:3")
      m.score.should == "3:1"
    end

    it "returns score for each player properly" do
      p1, p2 = create(:user), create(:user)
      m = build(:match, player1_id: p1.id, player2_id: p2.id)
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
      User.delete_all
      ro4 = create(:round)
      2.times { |i| create(:match, round: ro4, seed: i) }

      ro2 = create(:round, parent: ro4)
      last_match = create(:match, round: ro2, seed: 0)

      ro4.matches.first.next.should == last_match
    end
  end

  describe "unset_score" do
    it "unsets score from the followup matches" do
      m = stub(:match1, next: nil)
      m2 = create(:match)
      m2.stub(:next) { m }

      m.should_receive(:unset_score)
      m2.unset_score
    end
  end

  describe "unset player" do

    it "unsets a given player from the match" do
      m = build(:match)
      m.unset_player(m.player1)
      m.player1.should == nil

      m.unset_player(m.player2)
      m.player2.should == nil
    end

    it "raisees an exception if the given player isn't in the match" do
      expect {
        build(:match).unset_player(build(:user))
      }.to raise_error(Match::UnknownPlayer)
    end

  end
end
