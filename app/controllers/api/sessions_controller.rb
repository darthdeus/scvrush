class Api::SessionsController < ApplicationController

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
    session[:user_id] = nil
    render json: {}
  end

end
