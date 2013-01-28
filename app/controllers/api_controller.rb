class ApiController < ApplicationController

  respond_to :json

  def login
    user = User.with_login(params[:username])
    user_authenticator = UserAuthenticator.new(user)

    if user_authenticator.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { status: 'ok' }, status: 200
    else
      render json: { error: 401 }, status: 401
    end
  end

  def auth
    user = User.with_login(params[:username])
    user_authenticator = UserAuthenticator.new(user)

    if user_authenticator.authenticate(params[:password])
      user_authenticator.generate_api_key unless user.api_key?
      user.save!

      render json: { key: user.api_key }
    else
      render json: { error: 401 }, status: 401
    end
  end

  def check
    user = User.find_by_api_key(params[:api_key])
    if user
      render json: { status: 'ok' }
    else
      render json: { status: 'failure' }, status: 401
    end
  end

  def user_data
    user = UserDecorator.find_by_api_key(params[:api_key])
    if user.model
      render json: user.as_json(only: %w(username race league gravatar)), status: 200
    else
      render json: { status: 'failure' }, status: 404
    end
  end

  def streams
    render json: Stream.all
  end

end
