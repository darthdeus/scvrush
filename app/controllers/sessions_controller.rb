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
      flash[:success] = "You are now logged in. Enjoy the community!"
      redirect_to root_url
    else
      flash.now.alert = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    # cookies.delete(:auth_token)
    flash[:success] = "You have been logged out. Come back again at any time!"
    redirect_to root_url
  end
end
