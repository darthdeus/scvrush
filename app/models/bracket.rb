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
    rounds.each.with_index do |round, index|
      if index == 0
        text =<<MAPS
MLG Entombed Valley
GSL Metropolis
ESV Ohana LE
MAPS
      elsif index == 1
        text =<<MAPS
GSL Bel'Shir Beach (Winter)
ESL Cloud Kingdom
GSL Daybreak
MAPS
      end

      round = Round.new(number: round, tournament: tournament, text: text, parent: last)
      round.bo = [1,2,4].include?(round.number) ? 3 : 1

      # TODO - set the BO preset if there is one for given rounds
      if tournament.bo_preset
        bo_preset = tournament.bo_preset.split(" ").map(&:to_i)

        round.bo = bo_preset[index] if bo_preset[index]
      end

      if tournament.maps.present?
        round.text = tournament.maps[index] if tournament.maps[index]
      end


      round.save!

      last = round
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
    tournament.reload
    round = tournament.rounds.first

    matches = round.matches
    seed = 0

    players = tournament.checked_players

    # First half of the players
    index = 0
    while index < matches.size / 2
      matches[index].player1 = players.shift
      matches[-index - 1].player1 = players.shift

      index += 1
    end

    # Second half of the players
    index = 0
    while index < matches.size / 2
      matches[index].player2 = players.shift
      matches[-index - 1].player2 = players.shift

      index += 1
    end

    # Automatic walkovers
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

  # Set a score for a given player by figuring out what his
  # current match is, and then setting the result.
  def set_score_for(user, score, admin = false, opponent_id = nil)
    match = self.current_match_for(user)

    if not admin
      # A player can submit his match results only once
      raise AlreadySubmitted if match.winner
      raise NotStartedYet unless match.can_submit?
    end

    if opponent_id && match.opponent_for(user).id != opponent_id.to_i
      raise AlreadySubmitted
    end

    match.set_score_and_advance(user, score)
    match.save!

    # self.seed_next_match_with(match.winner, match)
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
    [256, 128, 64, 32, 16, 8, 4, 2, 1]
  end

end
