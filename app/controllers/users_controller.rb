class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update, :follow, :unfollow]
  before_filter :load_user, only: [:show, :follow, :unfollow, :info, :friends]

  def index
    redirect_to new_user_path
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
    @user = UserDecorator.new(@user)
    if @user.model.nil?
      flash[:error] = "The user doesn't exist"
      redirect_to root_path
    else
      @followers = UserDecorator.decorate(@user.followers)
      gon.user_id = params[:id]
    end
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
      flash[:error] =  "You can't follow yourself."
    else
      flash[:notice] = "You are now following #{@user.username}."
      current_user.follow @user
    end

    redirect_to @user
  end

  def unfollow
    current_user.unfollow @user
    redirect_to @user, notice: "You are not following #{@user.username} anymore."
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
    if id =~ /\d+(-.+)?/
      @user = User.includes(comments: :post).find(id)
    else
      @user = User.includes(comments: :post).find_by_username(id)
    end

    unless @user
      render file: "#{Rails.root}/public/404.html", status: 404
      return false
    end
  end

end
