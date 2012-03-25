class DashboardController < ApplicationController
  before_filter :require_writer, only: :index

  def index
    @drafts = Post.drafts.limit(10).order('updated_at DESC')
    @published = Post.published.limit(10).order('updated_at DESC')
    @recent_tournaments = Tournament.order('starts_at DESC')
    @raffles = Raffle.all

    ggbet = GGBet.new(Rails.cache)

    @ggbet_logo = ggbet.logo?
    @ggbet_widget = ggbet.widget?
  end

  def ggbet
    if logged_in? && current_user.has_role?(:admin)
      handle(params)
      status = 200
    else
      status = 401
    end

    respond_to do |format|
      format.json { render json: { status: status } }
    end
  end

  protected

  def handle(params)
    ggbet = GGBet.new(Rails.cache)
    ggbet.toggle_logo(params[:ggbet_logo]) if params[:ggbet_logo]
    ggbet.toggle_widget(params[:ggbet_widget]) if params[:ggbet_widget]
  end
end
