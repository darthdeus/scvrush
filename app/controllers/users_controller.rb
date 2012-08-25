class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update, :follow, :unfollow]

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
    # TODO - add search by username, for example, but still need
    # to decide if redirect isn't better
    # user = User.where("id = ? OR username = ?", id, id).includes(comments: :post).first
    user = User.includes(comments: :post).find(params[:id])

    @user = UserDecorator.new(user)
    @followers = UserDecorator.decorate(@user.followers)
    gon.user_id = params[:id]

    if @user.model.nil?
      flash[:error] = "The user doesn't exist"
      redirect_to root_path
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
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] =  "You can't follow yourself."
    else
      flash[:notice] = "You are now following #{@user.username}."
      current_user.follow @user
    end

    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
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

end
