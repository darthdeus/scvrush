class PlayerInfoDecorator

  def initialize(bracket, user)
    @bracket, @user = bracket, user
  end

  def current_match
    @bracket.current_match_for(@user)
  end

  def lost?
    @current_match && @current_match.loser?(@user)
  end

  def next_opponent
    @current_match && @current_match.opponent_for(@user)
  end

end
