class ApiController < ApplicationController

  def login
    user = User.with_login(params[:username])
    user_authenticator = UserAuthenticator.new(user)

    respond_to do |format|
      format.json do
        if user_authenticator.authenticate(params[:password])
          session[:user_id] = user.id
          render json: { status: 'ok' }, status: 200
        else
          render json: { error: 401 }, status: 401
        end
      end
    end
  end

  def auth
    user = User.with_login(params[:username])
    user_authenticator = UserAuthenticator.new(user)

    respond_to do |format|
      format.json do
        if user_authenticator.authenticate(params[:password])
          user_authenticator.generate_api_key unless user.api_key.present?
          user.save!

          render json: { key: user.api_key }
        else
          render json: { error: 401 }, status: 401
        end
      end
    end
  end

  def check
    user = User.find_by_api_key(params[:api_key])
    respond_to do |format|
      format.json do
        if user
          render json: { status: 'ok' }
        else
          render json: { status: 'failure' }, status: 401
        end
      end
    end
  end

end
