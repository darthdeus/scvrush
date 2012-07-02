class TournamentPlayerDecorator

  # Simulate a user if there isn't one for cleaner view
  class GuestUser
    def registered_for?(tournament)
      false
    end
  end

  def initialize(user, tournament)
    @tournament = tournament
    @user = user || GuestUser.new
  end

  def registered?
    @user.registered_for?(@tournament)
  end

end
