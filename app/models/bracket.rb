class Bracket

  class AlreadySubmitted < ::Exception; end
  class NotStartedYet < ::Exception; end

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

    last = nil

    rounds = self.round_sizes(tournament.checked_players.size)
    rounds.each do |round|
      text =<<TEXT
MLG Antiga Shipyard
GSL Bel'Shir Beach (Winter)
MLG Cloud Kingdom
TEXT

      round = Round.new(number: round, tournament: tournament, text: text, parent: last)
      round.bo = [1,2,4].include?(round) ? 3 : 1
      round.save!

      last = round
    end
  end

  def create_matches
    # We start from the highest round, e.g. Ro8, Ro4, Ro2
    # TODO - don't create Ro1 match
    rounds = tournament.rounds.order("number DESC")
    rounds.each do |round|
      (round.number / 2).times do |seed|
        round.matches.create!(seed: seed)
      end
    end
  end

  # Linear seed for the bracket
  def linear_seed
    tournament.reload
    round = tournament.rounds.first

    matches = round.matches
    seed = 0

    players = tournament.checked_players

    matches.each do |match|
      match.player1 = players.shift
      match.seed = seed
      seed += 1
    end

    matches.each do |match|
      match.player2 = players.shift
    end

    matches.each do |match|
      if match.player2.nil?
        match.completed = true
        self.seed_next_match_with(match.player1, match)
      end

      match.save(validate: false)
    end


#     tournament.checked_players.each_slice(2) do |players|
#       # TODO - instead of creating a new match, instead find
#       # the match that was pre-populated and seed the players to it
#       match = matches[seed]
#       # TODO - don't create it here
#       match = round.matches.create!(seed: seed) if match.nil?
#       match.player1 = players[0]
#       match.player2 = players[1]
# 
#       # TODO - seed the player automatically to the next round
#       if match.player2.nil?
#         match.completed = true
#         self.seed_next_match_with(match.player1, match)
#       end
#       match.seed = seed
#       # TODO - this isn't really a nice solution
#       match.save(validate: false)
#       seed += 1
#     end

  end

  # Set a score for a given player by figuring out what his
  # current match is, and then setting the result.
  def set_score_for(user, score, admin = false)
    match = self.current_match_for(user)

    if not admin
      # A player can submit his match results only once
      raise AlreadySubmitted if match.winner
      raise NotStartedYet unless match.can_submit?
    end

    match.set_score_for(user, score)
    match.save!

    self.seed_next_match_with(match.winner, match)
  end

  # Return next round number for a given number, e.g. 2 for 4
  def next_round_number(number)
    index = self.seeds.index(number)
    self.seeds[index + 1]
  end

  # Return next round for a given round, e.g. Ro2 for Ro4
  def next_round_for(round)
    number = self.next_round_number(round.number)
    self.tournament.rounds.where(number: number).first
  end

  def mark_winner(user)
    self.tournament.winner = user
    self.tournament.save!
  end

  # Seed the given player to a next round after he won his match
  #
  # Returns the winner if there was one, otherwise nil
  def seed_next_match_with(user, match)
    next_round = self.next_round_for(match.round)

    if next_round.number == 1
      self.mark_winner(user)
      return user
    end

    next_match = next_round.matches.where(seed: match.seed / 2).first

    if match.seed % 2 == 0
      next_match.player1 = user
    else
      next_match.player2 = user
    end

    next_match.completed = false
    # TODO - this isn't right
    next_match.save(validate: false)
    next_match
    return nil
  end

  # Return the current match for a given user. It should always be
  # the match with the lowers round number where the player is present.
  def current_match_for(user)
    matches = tournament.matches.to_a
    user_matches = matches.select { |m| m.player1_id == user.id || m.player2_id == user.id }
    user_matches.sort { |m1, m2| m1.round.number <=> m2.round.number }.first
  end

  # Return a current opponent for a user from his current match.
  def current_opponent_for(user)
    match = current_match_for(user)
    match.opponent_for(user) if match
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
