require "spec_helper"

describe Bracket do

  let(:bracket) { Bracket.new([]) }

  describe "seed size" do
    it "returns the next highest possible seed size for a given number" do
      bracket.find_seed(100).should == 128
      bracket.find_seed(60).should == 64
      bracket.find_seed(20).should == 32
      bracket.find_seed(17).should == 32
      bracket.find_seed(16).should == 16
    end

    it "won't allow to seed larger than maximum bracket" do
      expect { bracket.find_seed(200) }.to raise_error(ArgumentError)
    end

    it "can give rounds for a given tournament" do
      bracket.round_sizes(4).should == [4,2,1]
      bracket.round_sizes(5).should == [8,4,2,1]
    end

  end

  it "can create a bracket rounds" do
    t = create(:tournament)
    bracket = Bracket.new(t)
    4.times { t.users << create(:user) }

    bracket.create_bracket_rounds
    t.reload
    t.should have(3).rounds
  end

  it "seeds players to the bracket" do
    User.delete_all
    Match.delete_all

    t = create(:tournament)
    bracket = Bracket.new(t)
    p1, p2, p3, p4 = *4.times.inject([]) { |v,i| v << create(:user) }
    t.users << p1 << p2 << p3 << p4

    bracket.create_bracket_rounds
    bracket.linear_seed

    Match.count.should == 2
    Match.first.player1.should == p1
    Match.first.player2.should == p2
    Match.last.player1.should == p3
    Match.last.player2.should == p4
  end
#   describe "seeding" do
#
#     context "with a list of players" do
#       it "creates the first round" do
#         t = create(:tournament)
#         t.seed
#         t.should have(1).round
#       end
#
#       it "should assign the round number based of the amount of players" do
#         t = create(:tournament)
#         4.times { t.users << create(:user) }
#         t.seed
#         t.rounds.first.number.should == 4
#         t.should have(1).round
#       end
#
#     end
#   end
#
end
