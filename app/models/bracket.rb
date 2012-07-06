class Bracket

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

  def create_matches
    # We start from the highest round, e.g. Ro8, Ro4, Ro2
    # TODO - don't create Ro1 match
    rounds = tournament.rounds.order("number DESC")
    rounds.each do |round|
      (round.number / 2).times { round.matches.create!(bo: 3) }
    end
  end

  # Linear seed for the bracket
  def linear_seed
    tournament.reload
    round = tournament.rounds.first
    matches = round.matches
    index = 0
    # TODO - only checked in users here
    tournament.users.each_slice(2) do |players|
      # TODO - instead of creating a new match, instead find
      # the match that was pre-populated and seed the players to it
      match = matches[index]
      # TODO - don't create it here
      match = round.matches.create!(bo: 3)
      match.player1 = players[0]
      match.player2 = players[1]
      match.save!
      index += 1
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

#   def seed
#     number = self.players.size
#
#     self.rounds.create!(number: number)
#     # self.players.each_slice(2) do |players|
#     #
#     # end
#   end

end
