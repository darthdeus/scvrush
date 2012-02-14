class SessionsController < ApplicationController
  def new
    # there is no need to display login if the user is already logged in
    redirect_to current_user if logged_in?
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "You are now logged in. Enjoy the community!"
      redirect_to root_url
    else
      flash.now.alert = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out. Come back again at any time!"
    redirect_to root_url
  end
end
