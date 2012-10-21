class TournamentPlayerDecorator

  # Simulate a user if there isn't one for cleaner view
  class GuestUser
    def registered_for?(tournament)
      false
    end

    def checked_in?(tournament)
      false
    end

    def has_signup?(tournament)
      false
    end

    def id
      nil
    end
  end

  attr_reader :user

  # TODO - convert to draper with a call to super
  def initialize(user, tournament, bracket = nil)
    @tournament = tournament
    @user = user || GuestUser.new
  end

  def id
    @user.id
  end

  def registered?
    return false if @tournament.nil? || !@user.respond_to?(:signups)
    !@user.signups.registered.where(tournament_id: @tournament.id).empty?
  end

  def checked_in?
    return false if @tournament.nil? || !@user.respond_to?(:signups)
    !@user.signups.checked.where(tournament_id: @tournament.id).empty?
  end

  def has_signup?
    return false if @tournament.nil?
    @user.has_signup?(@tournament)
  end

  def next_opponent
  end

end
