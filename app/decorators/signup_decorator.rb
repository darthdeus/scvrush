class SignupDecorator

  def initialize(user, tournament)
    @user, @tournament = user, tournament
  end

  def can_signup?
    @user.registered_for?(@tournament)
  end
end
