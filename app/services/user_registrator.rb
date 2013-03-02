class UserRegistrator < Struct.new(:user, :tournament)

  def signup
    signup = Signup.for(user, tournament)
    signup.signup!
    signup
  end

  def checkin
    signup = Signup.for(user, tournament)
    signup.checkin!
    signup
  end

  def post_status(signup)
    if signup.checked?
      Status.create!(user: user, text: "I just checked in for #{signup.tournament.name}")
    else
      Status.create!(user: user, text: "I just registered for #{signup.tournament.name}")
    end
  end

end
