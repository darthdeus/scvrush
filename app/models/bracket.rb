class Bracket < Struct.new(:tournament)

  class AlreadySubmitted < ::Exception; end
  class NotStartedYet < ::Exception; end

  # attr_reader :tournament

  # def initialize(tournament)
  #   @tournament = tournament
  # end

  # Create a bracket for a given tournament id
  def self.with_tournament(id)
    Bracket.new(Tournament.find(id))
  end

  def to_json
    {
      id: tournament.id,
      tournament_id: tournament.id
    }
  end

  # Return JSON-formatted user data
  # def to_json
  #   user_data = map_users(@users)
  #   user_data.to_json
  # end

  def map_users(users)
    users.map.with_index { |user, index| { id: user.id, name: user.username, seed: index + 1 } }
  end

  # Create bracket rounds for the given tournament
  def create_bracket_rounds
    tournament.rounds = []
    last = nil
    round_creator = RoundCreator.new

    rounds = self.round_sizes(tournament.checked_players.size)
    rounds.each.with_index do |round, index|
      last = round = round_creator.create(tournament, round, last, index)
      round.save!
    end
  end

  def matches
    self.tournament.matches.order(:id)
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

  # Seeding first half of players, oscilating between first and last,
  # for example
  #
  # 1, 3
  # 2, 4
  def linear_seed
    Rails.logger.info "starting linear seed for tournament #{tournament.id}"
    tournament.reload
    round   = tournament.rounds.first
    matches = round.matches
    players = tournament.checked_players

    # Seed both first and second half of the players
    [:player1=, :player2=].each do |attr|
      index = 0
      while index < matches.size / 2
        matches[index]     .send(attr, players.shift)
        matches[-index - 1].send(attr, players.shift)
        index += 1
      end
    end

    resolve_walkovers(matches)
  end

  # Automatic walkovers when there is no opponent for the player
  def resolve_walkovers(matches)
    matches.each do |match|
      if match.player2.nil?
        match.completed = true
        self.seed_next_match_with(match.player1, match)
      end

      match.save(validate: false)
    end
  end

  def next_match(round, seed)
    round.matches.order(:id).where(seed: seed / 2).first
  end

  # Seed the given player to a next round after he won his match
  #
  # Returns the winner if there was one, otherwise nil
  def seed_next_match_with(user, match)
    next_round = match.round.next

    if next_round.number == 1
      self.mark_winner(user)
      return user
    end

    next_match = self.next_match(next_round, match.seed)
    next_match.seed_player(user, match.seed)
    # TODO - this isn't right
    next_match.save(validate: false)

    return nil
  end

  # Set a score for a given player by figuring out what his
  # current match is, and then setting the result.
  def set_score_for(user, score, admin = false, opponent_id = nil)
    match = self.current_match_for(user)

    if not admin
      # A player can submit his match results only once
      raise AlreadySubmitted if match.winner
      raise NotStartedYet unless match.can_submit?
    end

    # TODO - figure out if some tests break this
    if opponent_id && match.opponent_for(user).bnet_info != opponent_id
      raise AlreadySubmitted
    end

    match.set_score_and_advance(user, score)
    match.save!
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

  # Return the current match for a given user. It should always be
  # the match with the lowers round number where the player is present.
  def current_match_for(user)
    tournament.reload
    search = MatchSearch.new(tournament.matches.to_a)
    search.for_user(user.id)
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
    [512, 256, 128, 64, 32, 16, 8, 4, 2, 1]
  end

end
