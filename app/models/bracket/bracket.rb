class Bracket::Bracket

  attr_reader :tournament

  def initialize(tournament)
    @tournament = tournament
  end

  # Return JSON-formatted user data
  def to_json
    user_data = map_users(@users)
    user_data.to_json
  end

  def map_users(users)
    users.map.with_index { |user, index| { id: user.id, name: user.username, seed: index + 1 } }
  end

  # Create bracket rounds for the given tournament
  def create_bracket_rounds
    # TODO - do we really want to erase previous rounds?
    tournament.rounds = []
    # TODO - maybe only count checked in players
    rounds = self.round_sizes(tournament.users.size)
    rounds.each do |round|
      round = Round.new(number: round, tournament: tournament)
      round.save
    end
  end

  # Return round sizes for a given player count
  def round_sizes(player_count)
    seed = self.find_seed(player_count)
    seeds[seeds.index(seed)..-1]
  end

  # Find a bracket seed for a given number of players
  def find_seed(number_of_players)
    if number_of_players > seeds.first
      raise ArgumentError, "Cannot create bracket larger than #{seeds.first}"
    end

    seeds = self.seeds()

    begin
      current = seeds.pop()
    end while current < number_of_players
    return current
  end

  # Returns true if the round has a next round
  def has_next_round?(round)
    self.seeds.index(round) > 1
  end

  # Return the next round for a given round
  def next_round(round)
    index = self.seeds.index(round)
    if index > 1
      self.seeds[index + 1]
    elsif index == 1
      return nil
    else
      raise ArgumentError, "Invalid round"
    end
  end

  # Seeds for the bracket
  def seeds
    [128, 64, 32, 16, 8, 4, 2, 1]
  end

  def linear_seed
    tournament.reload
    round = tournament.rounds.first
    tournament.users.each_slice(2) do |players|
      match = Match.new(round: round)
      match.player1 = players[0]
      match.player2 = players[1]
      match.bo = 3
      match.save!
    end
  end
#   def seed
#     number = self.players.size
#
#     self.rounds.create!(number: number)
#     # self.players.each_slice(2) do |players|
#     #
#     # end
#   end

end
