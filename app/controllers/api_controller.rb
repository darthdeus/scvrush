class ApiController < ApplicationController

  def login
    user = User.authenticate(params[:username], params[:password])
    respond_to do |format|
      format.json do
        if user
          session[:user_id] = user.id
          render json: { status: 'ok' }, status: 200
        else
          render json: { error: 401 }, status: 401
        end
      end
    end
  end

  def auth
    user = User.authenticate(params[:username], params[:password])
    respond_to do |format|
      format.json do
        if user
          user.generate_api_key! unless user.api_key.present?
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

  def friends
    user = User.find_by_username(params[:username])
    if user
      render json: { friends: user.friends.map(&:username) }
    else
      render json: { error: 404 }, status: 404
    end
  end
end
