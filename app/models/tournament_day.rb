class TournamentDay

  def self.by_days(user)
    data = Tournament.recent.group_by { |t| t.starts_at.to_date }.to_a

    days = data.map.with_index { |pair, index|
      { id: index, date: pair[0], tournaments: pair[1].as_json(user: user) }
    }
  end

end
