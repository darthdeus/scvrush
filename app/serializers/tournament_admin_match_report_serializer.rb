class TournamentAdminMatchReportSerializer < MatchSerializer
  self.root = "match"

  has_many :tournaments, include: true, embed: :ids
  has_many :matches, include: true, embed: :ids

  def tournaments
    [object.round.tournament]
  end

  def matches
    object.round.tournament.matches
  end

end
