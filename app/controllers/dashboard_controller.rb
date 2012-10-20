class DashboardController < ApplicationController
  before_filter :require_writer, only: :index

  def index
    @drafts = Post.drafts.limit(10).order('updated_at DESC')
    @published = Post.published.limit(10).order('updated_at DESC')
    @recent_tournaments = Tournament.order('starts_at DESC')
    @raffles = Raffle.all
  end

end
