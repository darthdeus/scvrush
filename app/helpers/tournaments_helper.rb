module TournamentsHelper
  def signups_open?(tournament)
    tournament.starts_at > 15.minutes.from_now    
  end
end
