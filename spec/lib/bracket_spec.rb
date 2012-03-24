class Bracket

  attr_reader :players

  def initialize
    @players = []
  end

  def seed(players)
    players.each { |player| @players << player }
  end

  def start
  end
end

describe Bracket do
  subject { Bracket.new }

  it "takes a list of players" do
    players = %w(foo bar baz)
    subject.seed(players)
    subject.players.first.should == "foo"
  end

  it "can start" do
    subject.start
  end
end