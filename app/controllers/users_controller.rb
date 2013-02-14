class UsersController < ApplicationController
  respond_to :json

  def index
    if params[:ids]
      users = User.find_all_by_id(params[:ids])
    elsif params[:username]
      users = User.find_all_by_username(params[:username])
    elsif params[:query]
      # users = User.search(params[:query], load: true).to_a
      users = User.find_all_by_username("%#{params[:query]}%").limit(20)
    else
      users = User.first(20)
    end

    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = current_user
    attributes = {
      username: params[:user][:username],
      email: params[:user][:email],
      race: params[:user][:race],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
      bnet_info: params[:user][:bnet_info],
    }

    attributes[:expires_at] = nil if attributes[:password]

    # TODO - check the bang ! here
    user.update_attributes!(attributes)

    render json: user
  end

  def follow
    user = User.find(params[:id])
    if user == current_user
      render json: { error: "You can't follow yourself" }, status: 400
    else
      current_user.follow user
      render json: [ current_user, user ]
    end
  end

  def unfollow
    user = User.find(params[:id])
    current_user.unfollow user
    render json: [ current_user, user ]
  end

  # API for chat
  def info
    user = User.find_by_username(params[:id])
    if user
      info = UserInfoDecorator.new(user)
      render json: info.as_json
    else
      render json: { error: 404 }, status: 404
    end
  end

  def friends
    if user = User.find(params[:id])
      render json: { friends: user.friends.map(&:username) }
    else
      render json: { error: 404 }, status: 404
    end
  end

end
