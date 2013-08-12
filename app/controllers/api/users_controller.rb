class Api::UsersController < ApplicationController
  respond_to :json

  def index
    users = User.scoped

    if params[:query]
      users = users.where("bnet_username ILIKE ?", "%#{params[:query]}%")

      render json: {
        options: users.map { |user| "#{user.id},#{user.username},#{user.bnet_info}" }
      }
    else
      render json: []
    end
  end

end
