class UsersController < ApplicationController
  # before_filter :require_login, only: [:edit, :update, :follow, :unfollow]
  before_filter :load_user, only: [:show, :follow, :unfollow, :info, :friends]

  respond_to :json

  def index
    if params[:ids]
      @users = User.find_all_by_id(params[:ids])
    elsif params[:username]
      @users = User.find_all_by_username(params[:username])
    else
      @users = User.first(20)
    end

    respond_with @users
  end

  def show
    respond_with @user
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

    user.update_attributes(attributes)

    render json: user
  end

  def follow
    if @user == current_user
      render json: { error: "You can't follow yourself" }, status: 400
    else
      current_user.follow @user
      render json: [ current_user, @user ]
    end
  end

  def unfollow
    current_user.unfollow @user
    render json: [ current_user, @user ]
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
    if @user
      render json: { friends: @user.friends.map(&:username) }
    else
      render json: { error: 404 }, status: 404
    end
  end

  protected

  def load_user
    id = params[:id]
    # @user = (id =~ /\d+(-.+)?/) ? User.find_by_id(id) : User.find_by_username(id.downcase)
    @user = User.find(id)

    unless @user
      render file: "#{Rails.root}/public/404.html", status: 404
      return false
    end
  end

end
