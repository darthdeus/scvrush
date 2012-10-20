class MatchSearch

  def initialize(matches)
    @matches = matches
  end

  def for_user(user_id)
    matches = @matches.select { |m| m.player1_id == user_id || m.player2_id == user_id }
    matches.sort { |m1, m2| m1.round.number <=> m2.round.number }.first
  end
end
