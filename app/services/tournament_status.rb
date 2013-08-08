class TournamentStatus
  def intiialize(tournament)
    @tournament = tournament
  end

  def registration_open?
    @tournament.starts_at? > Time.zone.now
  end

  def checkin_open?
    @tournament.starts_at < 60.minutes.from_now && @tournament.starts_at > Time.zone.now
  end

  def started?
    @tournament.starts_at < Time.zone.now
  end

  def registered?(user)
    Signup.exist?(tournament_id: @tournament.id, user_id: user.id)
  end
end
