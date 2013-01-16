class UserRegistrator < Struct.new(:user, :tournament)

  def signup
    signup = Signup.for(user, tournament)
    signup.signup!
  end

  def checkin
    signup = Signup.for(user, tournament)
    signup.checkin!
  end

end
