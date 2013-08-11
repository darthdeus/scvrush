class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :current_user, :logged_in?

  protected

  def require_login
    unless logged_in?
      if request.xhr?
        render json: { error: 'unauthorized' }, status: :unauthorized
      else
        if request.post?
          session[:redirect_back] = env["HTTP_REFERER"]
        else
          session[:redirect_back] = request.original_fullpath
        end
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_path
      end
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

  def current_user
    login_or_trial
    return @current_user if @current_user

    user = User.find_by_id(session[:user_id])
    if user
      @current_user = user
    else
      redirect_to root_path, notice: "There was an error when creating a trial account, we've been notified"
      session.delete(:user_id)
      nil
    end
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def logged_in?
    !!current_user
  end

  def login_or_trial
    unless User.exists?(id: session[:user_id])
      Trial.new.create(session, request.remote_ip)
    end
  end

end
