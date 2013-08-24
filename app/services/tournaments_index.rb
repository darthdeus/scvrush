class TournamentsIndex
  def this_week
    group_by_day(Tournament.in_range(Time.zone.now, 1.week.from_now).official.ordered)
  end

  def next_week
    group_by_day(Tournament.in_range(1.week.from_now, 2.weeks.from_now).official.ordered)
  end

  def past
    group_by_day(Tournament.past.limit(20).official.ordered)
  end

  def all
    group_by_day(Tournament.limit(20).ordered.official)
  end

  private

  def group_by_day(tournaments)
    tournaments.group_by { |tournament| tournament.starts_at.to_date }
  end
end
