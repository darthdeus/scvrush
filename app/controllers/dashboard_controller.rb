class DashboardController < ApplicationController
  before_filter :require_writer, :only => :index

  def index
    @drafts = Post.drafts.limit(10)
    @published = Post.published.limit(10)
    @recent_tournaments = Tournament.order('starts_at DESC')
    @raffles = Raffle.all

    @ggbet_logo = Rails.cache.read('ggbet_logo')
  end

  def ggbet

    if logged_in? && current_user.role < User::WRITER
      status = 401
    else
      status = 200
    end

    handle(params)

    respond_to do |format|
      format.json { render :json => { status: status } }
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
      else
        logger.info "invalid ggbet value #{params[:ggbet_logo].inspect}"
    end
  end

end
