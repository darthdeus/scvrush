class SessionsController < ApplicationController
  layout "login"

  def new
    session[:redirect_back] = params[:redirect_back] if params[:redirect_back]
    # there is no need to display login if the user is already logged in
    redirect_to current_user if logged_in?
  end

  def create
    user = User.with_login(params[:username])

    authenticated = UserAuthenticator.new(user).authenticate(params[:password])

    respond_to do |format|
      format.html do
        if authenticated
          session[:user_id] = user.id
          flash[:success] = "You are now logged in. Enjoy the community!"
          redirect_back_or_default
        else
          flash.now.alert = "Invalid username or password."
          render "new"
        end
      end

      format.json do
        if authenticated
          session[:user_id] = user.id
          render json: user
        else
          render json: { error: "Invalid credentials" }, status: 402
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out. Come back again at any time!"
    if params[:r].present?
      redirect_to params[:r]
    else
      redirect_to root_path
    end
  end
end
