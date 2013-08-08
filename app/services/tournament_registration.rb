class TournamentRegistration
  attr_reader :tournament, :user, :player

  def initialize(tournament, user)
    @tournament, @user = tournament, user
    @player = TournamentPlayerDecorator.new(user, tournament)
  end

  def checked_in?
    player.checked_in?
  end

  def registered?
    player.registered?
  end

  def status
    if player.checked_in?
      :update
    elsif player.registered? && tournament.checkin_open?
      :check_in
    elsif player.registered? && !tournament.checkin_open?
      :update
    elsif !player.registered? && tournament.checkin_open?
      :register_and_check_in
    elsif !player.registered? && tournament.registration_open?
      :register
    else
      raise "Internal consistency error herp derp"
    end
  end

  def button_text
    case status
    when :update then "Update Information"
    when :check_in then "Check in"
    when :register_and_check_in then "Register and automatically check in"
    when :register then "Register"
    else raise "Interal consistency error herp derp"
    end
  end

  def signup
    Signup.for(user, tournament)
  end
end
