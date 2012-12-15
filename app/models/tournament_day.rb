class TournamentDay

  def self.by_days
    recent = Tournament.recent
    data = recent.group_by { |t| t.starts_at.to_date }.to_a

    days = data.map.with_index { |pair, index|
      { id: index, date: pair[0], tournaments: pair[1].map(&:id) }
    }
  end

end
