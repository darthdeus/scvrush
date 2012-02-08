class DashboardController < ApplicationController
  before_filter :require_writer

  def index
    @drafts = Post.drafts.limit(10)
    @published = Post.published.limit(10)
    @recent_tournaments = Tournament.order('starts_at DESC')
    @raffles = Raffle.all
  end

  def ggbet
    handle(params)

    respond_to do |format|
      format.json { render :json => { status: 200 } }
    end
  end

  protected

  def handle(params)
    case params[:ggbet_logo]
      when '1'
        Rails.cache.write('ggbet_logo', true)
        logger.info 'ggbet enabled'
      when '0'
        Rails.cache.write('ggbet_logo', nil)
        logger.info 'ggbet disabled'
    end
  end

end
