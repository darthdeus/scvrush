class TournamentPlayerDecorator

  attr_reader :user, :tournament

  def initialize(user, tournament, bracket = nil)
    @tournament = tournament
    @user = user || GuestUser.new
  end

  def id
    @user.id
  end

  def registered?
    with_valid_attributes do
      !@user.signups.registered.where(tournament_id: @tournament.id).empty?
    end
  end

  def checked_in?
    with_valid_attributes do
      !@user.signups.checked.where(tournament_id: @tournament.id).empty?
    end
  end

  def with_valid_attributes(&block)
    (@tournament.nil? || !@user.respond_to?(:signups)) ? false : yield
  end

  def has_signup?
    return false if @tournament.nil?
    @user.has_signup?(@tournament)
  end

  def register
    if signup = @tournament.signup_for(@user)
    else
      signup = Signup.for(@user, @tournament)
    end
  end

  def next_opponent
  end

end
