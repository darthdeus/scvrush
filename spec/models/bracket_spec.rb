require "spec_helper"

describe Bracket do

  def seeded_with(num)
    t = create(:tournament)
    bracket = Bracket.new(t)

    players = num.times.inject([]) { |all, _| all << create(:user) }
    players.each do |p|
      t.users << p
      p.check_in(t)
    end

    return [bracket, players]
  end

  let(:bracket) { Bracket.new([]) }

  it "can create a bracket for given tournament id" do
    t = create(:tournament)
    bracket = Bracket.with_tournament(t.id)
    bracket.tournament.should == t
  end

  describe "seed size" do
    it "returns the next highest possible seed size for a given number" do
      bracket.find_seed(400).should == 512
      bracket.find_seed(200).should == 256
      bracket.find_seed(100).should == 128
      bracket.find_seed(60).should == 64
      bracket.find_seed(20).should == 32
      bracket.find_seed(17).should == 32
      bracket.find_seed(16).should == 16
    end

    it "won't allow to seed larger than maximum bracket" do
      expect { bracket.find_seed(600) }.to raise_error(ArgumentError)
    end

    it "can give rounds for a given tournament" do
      bracket.round_sizes(4).should == [4,2,1]
      bracket.round_sizes(5).should == [8,4,2,1]
    end

  end

  it "can create a bracket rounds" do
    t = create(:tournament)
    bracket = Bracket.new(t)
    4.times do
      u = create(:user)
      t.users << u
      u.check_in(t)
    end

    bracket.create_bracket_rounds
    t.reload
    t.should have(3).rounds
  end

  it "sets score in proper order" do
    t = create(:tournament)
    bracket = Bracket.new(t)
    p1, p2, p3, p4 = *4.times.inject([]) { |v,i| v << create(:user) }
    t.users << p1 << p2 << p3 << p4
    [p1, p2, p3, p4].each { |u| u.check_in(t) }

    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    bracket.set_score_for(p2, "3:1", false)

    expect do
      bracket.set_score_for(p1, "1:3", false, p1.id)
    end.to raise_error(Bracket::AlreadySubmitted)
  end

  it "seeds players to the bracket" do
    User.delete_all
    Match.delete_all

    t = create(:tournament)
    bracket = Bracket.new(t)
    p1, p2, p3, p4 = *4.times.inject([]) { |v,i| v << create(:user) }
    t.users << p1 << p2 << p3 << p4
    [p1, p2, p3, p4].each { |u| u.check_in(t) }

    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    Match.count.should == 3

    matches = Match.order(:id).first(2)
    matches[0].player1.should == p1
    matches[0].player2.should == p3
    matches[1].player1.should == p2
    matches[1].player2.should == p4
  end

  it "can give the current match for a user" do
    User.delete_all

    t = create(:tournament)
    bracket = Bracket.new(t)
    p1, p2, p3, p4 = *4.times.inject([]) { |v,i| v << create(:user) }
    t.users << p1 << p2 << p3 << p4
    [p1, p2, p3, p4].each { |u| u.check_in(t) }

    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    bracket.current_match_for(p1).player2.should == p3
    bracket.current_match_for(p2).player2.should == p4
    bracket.current_match_for(p3).player1.should == p1
    bracket.current_match_for(p4).player1.should == p2
  end

  it "seeds player to the next round" do
    Round.delete_all
    User.delete_all

    t = create(:tournament)
    bracket = Bracket.new(t)
    p1, p2, p3, p4 = *4.times.inject([]) { |v,i| v << create(:user) }
    t.users << p1 << p2 << p3 << p4
    [p1, p2, p3, p4].each { |u| u.check_in(t) }

    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    match = bracket.current_match_for(p1)
    bracket.seed_next_match_with(p1, match)

    rounds = t.rounds.order(:id)

    ro2 = rounds.second
    ro2.number.should == 2
    ro2.matches.first.player1.should == p1

    # It really shouldn't matter if we re-seed the player,
    # as the previous one gets overwritten. All we care about
    # is proper position
    bracket.seed_next_match_with(p3, match)

    ro2.reload
    ro2.matches.first.player1.should == p3

    # Seeding player from even match number should result in
    # him being put in the second position in a match.
    match2 = bracket.current_match_for(p2)
    bracket.seed_next_match_with(p2, match2)

    ro2.matches.first.player2.should == p2
  end

  it "returns next round number" do
    bracket = Bracket.new(nil)
    bracket.next_round_number(32).should == 16
    bracket.next_round_number(16).should == 8
    bracket.next_round_number(8).should == 4
    bracket.next_round_number(4).should == 2
    bracket.next_round_number(2).should == 1
    bracket.next_round_number(1).should == nil
  end

  it "automatically seeds the player to the next match if he has no opponent" do
    bracket, players = seeded_with(3)

    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    matches = bracket.matches.order(:id)

    matches[1].should be_completed
    bracket.current_match_for(players[1]).should == matches[2]
  end

  it "should delete the user from all followup matches when he's deleted from a match" do
    User.destroy_all
    Match.destroy_all

    bracket, players = seeded_with(11)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    players = bracket.matches.map { |m| [m.player1, m.player2] }.flatten.compact
    players.uniq.size.should == 11
  end

  it "should delete the user from all followup matches when he's deleted from a match" do
    User.destroy_all
    Match.destroy_all

    bracket, players = seeded_with(8)

    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    bracket.set_score_for(players[0], "1:0")
    bracket.set_score_for(players[2], "1:0")
    bracket.set_score_for(players[0], "1:0")

    matches = bracket.matches

    m = matches.first
    m.unset_score
    m.next.player1.should == nil
  end

end
