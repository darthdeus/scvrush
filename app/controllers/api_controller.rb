class ApiController < ApplicationController
  # force_ssl

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
end
