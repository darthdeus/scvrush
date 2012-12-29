class UsersController < ApplicationController
  # before_filter :require_login, only: [:edit, :update, :follow, :unfollow]
  before_filter :load_user, only: [:show, :follow, :unfollow, :info, :friends]

  respond_to :json

  def index
    if params[:ids]
      @users = User.find_all_by_username(params[:ids])
    elsif params[:username]
      @users = User.find_by_username(params[:username])
    else
      @users = User.first(20)
    end

    respond_with @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Signed up!"
    else
      render "new"
    end
  end

  def show
    respond_with UserDecorator.new(@user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Your profile was successfully updated."
      redirect_back_or @user
    else
      render 'edit'
    end
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
    @user = (id =~ /\d+(-.+)?/) ? User.find_by_id(id) : User.find_by_username(id.downcase)

    unless @user
      render file: "#{Rails.root}/public/404.html", status: 404
      return false
    end
  end

end
