class DashboardController < AuthenticatedController

  def index
    @upcoming_tournaments = Tournament.order(:starts_at).limit(3)
  end

end
