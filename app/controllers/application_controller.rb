class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  protected

  def require_writer
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif current_user.role < User::WRITER
      logger.warn "Access denied for #{current_user} with role #{current_user.role}"
      flash[:error] = "Access denied! You're not authorized to do this."
      redirect_back_or_root
    end
  end

  def require_login
     unless logged_in?
       flash[:error] = "You must be logged in to access this section"
       redirect_to login_path
     end
  end

  def redirect_back_or_default
    if session[:redirect_back]
      redirect_to session[:redirect_back]
    else
      redirect_to root_path
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def redirect_back_or_root
    if request.env["HTTP_REFERER"] && !request.xhr?
      redirect_to :back
    else
      redirect_to root_path
    end
  end
end
