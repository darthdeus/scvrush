class UserRegistrator < Struct.new(:user, :tournament)

  def signup
    signup = Signup.for(user, tournament)
    signup.signup!
    publish(tournament, user)
    signup
  end

  def checkin
    signup = Signup.for(user, tournament)
    signup.checkin!
    publish(tournament, user)
    signup
  end

  def post_status(signup)
    status = nil

    if signup.checked?
      status = Status.create!(user: user, text: "I just checked in for #{signup.tournament.name}")
    else
      status = Status.create!(user: user, text: "I just registered for #{signup.tournament.name}")
    end

    json = StatusSerializer.new(status).as_json(root: false)

    CS.publish("scvrush", {
      type: "Scvrush.Status",
      data: json
    })
  rescue Errno::ECONNREFUSED => e
    Rails.logger.error e
  end

  def publish(tournament, user)
    # json = TournamentSerializer.new(tournament, scope: user).as_json
    # CS.publish("scvrush", {
    #   type: "Scvrush.Tournament",
    #   data: json
    # })
  end

end
