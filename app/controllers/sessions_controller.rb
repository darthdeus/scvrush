class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      # if params[:remember_me]
      #   cookies.permanent[:auth_token] = user.auth_token
      # else
      #   cookies[:auth_token] = user.auth_token
      # end
      redirect_to root_url, :notice => "You are now logged in. Enjoy the community!"
    else
      flash.now.alert = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    # cookies.delete(:auth_token)
    redirect_to root_url, :notice => "You have been logged out. Come back again at any time!"
  end
end
