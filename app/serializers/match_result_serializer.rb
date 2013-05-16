class TournamentMatchReportSerializer < TournamentSerializer
  self.root = "tournament"
  has_many :matches, embed: :ids, include: true
end
