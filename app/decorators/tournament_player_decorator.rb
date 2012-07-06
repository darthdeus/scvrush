class TournamentPlayerDecorator

  # Simulate a user if there isn't one for cleaner view
  class GuestUser
    def registered_for?(tournament)
      false
    end

    def checked_in?(tournament)
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

  def checked_in?
    @user.checked_in?(@tournament)
  end

  def check_in!
  end

end
