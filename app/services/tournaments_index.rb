class TournamentsIndex
  def this_week
    now = Time.zone.now
    group_by_day(Tournament.in_range(now.beginning_of_week, now.end_of_week).official.monday_first)
  end

  def next_week
    week = 1.week.from_now
    group_by_day(Tournament.in_range(week.beginning_of_week, week.end_of_week).official.monday_first)
  end

  def past
    group_by_day(Tournament.past.limit(20).official.ordered)
  end

  def all
    group_by_day(Tournament.limit(20).ordered.official)
  end

  private

  # :: [Tournament] -> { Date => [Tournament] }
  def group_by_day(tournaments)
    tournaments.group_by { |tournament| tournament.starts_at.to_date }
  end
end
