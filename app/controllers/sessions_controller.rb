class SessionsController < ApplicationController

  def new
    session[:redirect_back] = params[:redirect_back] if params[:redirect_back]
    # there is no need to display login if the user is already logged in
    redirect_to current_user if logged_in? && !current_user.trial?
  end

  def create
    user = User.with_login(params[:username])

    if UserAuthenticator.new(user).authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in. Enjoy the community!"
      redirect_back_or home_path
    else
      flash.now.alert = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out. Come back again at any time!"
    redirect_back_or root_path
  end
end
