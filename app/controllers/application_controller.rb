class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |ex|
    flash[:error] = ex.message
    redirect_to root_path
  end

  protected

  def require_writer
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif !current_user.has_role?(:writer)
      logger.warn "Access denied for #{current_user} with role #{current_user.role}"
      flash[:error] = "Access denied! You are not authorized to do this."
      redirect_back_or_root
    end
  end

  def require_login
    unless logged_in?
      if request.post?
        session[:redirect_back] = env["HTTP_REFERER"]
      else
        session[:redirect_back] = request.original_fullpath
      end
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def redirect_back_or(model)
    if session[:redirect_back]
      uri = session[:redirect_back].dup
      session[:redirect_back] = nil
      redirect_to uri
    else
      redirect_to model
    end
  end

  def redirect_back_or_default
    if session[:redirect_back]
      uri = session[:redirect_back].dup
      session[:redirect_back] = nil
      redirect_to uri
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
