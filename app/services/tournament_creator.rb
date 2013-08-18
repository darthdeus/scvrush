class TournamentCreator
  def create(user, params)
    tournament = user.tournaments.build(params)
    tournament.tournament_type = Tournament::TYPE_USER
    tournament.bo_preset = "1"
    tournament.save
    tournament
  end
end
