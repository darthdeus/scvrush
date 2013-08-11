class UserRegistrator < Struct.new(:signup)
  def forward
    registration = TournamentRegistration.new(signup.tournament, signup.user)

    case registration.status
    when :register
      register(registration)
      "You have successfully registered for the tournament."
    when :check_in
      check_in(registration)
      "You've been checked in! Enjoy the tournament."
    when :register_and_check_in
      register_and_check_in(registration)
      "You've been registered and automatically checked in. Please wait for the tournament to start."
    when :update
      "Your profile was updated."
    end
  end

  def register(registration)
    signup.register
  end

  def check_in(registration)
    signup.checkin
  end

  def register_and_check_in(registration)
    signup.checkin
  end
end
