class DashboardController < ApplicationController
  before_filter :require_writer

  def index
    @drafts = Post.drafts.limit(10)
    @published = Post.published.limit(10)
    @recent_tournaments = Tournament.recent
    @raffles = Raffle.all
  end

end
