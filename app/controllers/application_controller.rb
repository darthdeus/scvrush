class ApplicationController < ActionController::Base
  protect_from_forgery  
  helper_method :current_user, :logged_in?
  
  
  protected

  def require_writer
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif current_user.role < User::WRITER
      flash[:error] = "Access denied! You're not authorized to do this."
      redirect_to root_path
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
    # @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def logged_in?
    !!current_user
  end
end
