class DashboardController < ApplicationController
  before_filter :require_writer, :only => :index

  def index
    @drafts = Post.drafts.limit(10)
    @published = Post.published.limit(10)
    @recent_tournaments = Tournament.order('starts_at DESC')
    @raffles = Raffle.all

    @ggbet_logo = Rails.cache.read('ggbet_logo')
    @ggbet_widget = Rails.cache.read('ggbet_widget')
  end

  def ggbet

    if logged_in? && current_user.role >= User::WRITER
      handle(params)
      status = 200
    else
      status = 401
    end


    respond_to do |format|
      format.json { render :json => { status: status } }
    end
  end

  protected

  def handle(params)
    case params[:ggbet_logo]
      when '1'
        Rails.cache.write('ggbet_logo', true)
        logger.info 'ggbet logo enabled'
      when '0'
        Rails.cache.write('ggbet_logo', nil)
        logger.info 'ggbet logo disabled'
      else
        logger.info "invalid ggbet_logo value #{params[:ggbet_logo].inspect}" if params[:ggbet_logo]
    end

    case params[:ggbet_widget]
      when '1'
        Rails.cache.write('ggbet_widget', true)
        logger.info 'ggbet widget enabled'
      when '0'
        Rails.cache.write('ggbet_widget', nil)
        logger.info 'ggbet widget disabled'
      else
        logger.info "invalid ggbet_widget value #{params[:ggbet_widget].inspect}" if params[:ggbet_widget]
    end
  end
end
