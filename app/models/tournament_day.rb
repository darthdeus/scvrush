class TournamentDay

  def self.by_days
    data = Tournament.recent.group_by { |t| t.starts_at.to_date }.to_a

    days = data.map.with_index { |pair, index|
      tournaments = pair[1].map { |tour| TournamentSerializer.new(tour) }
      { id: index, date: pair[0], tournaments: tournaments.as_json(root: false) }
    }
  end

end
