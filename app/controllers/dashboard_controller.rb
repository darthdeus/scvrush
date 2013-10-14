class DashboardController < AuthenticatedController

  def index
    @upcoming_tournaments = Tournament.order("starts_at DESC").limit(3)
    @news = current_user.suggested_posts
  end

end
