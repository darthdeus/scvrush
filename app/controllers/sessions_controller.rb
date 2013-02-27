class SessionsController < ApplicationController

  def create
    user = User.with_login(params[:username])

    authenticated = UserAuthenticator.new(user).authenticate(params[:password])

    if authenticated
      session[:user_id] = user.id
      render json: user
    else
      render json: { error: "Invalid credentials" }, status: 401
    end
  end

  def destroy
    raise "Implement me"

    session[:user_id] = nil
    flash[:success] = "You have been logged out. Come back again at any time!"
    if params[:r].present?
      redirect_to params[:r]
    else
      redirect_to root_path
    end
  end

end
