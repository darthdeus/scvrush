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
    # @user = User.where("id = ? OR username = ?", params[:id],
    # params[:id]).includes(comments: :post)
    # @user = User.find_by_username_or_id(params[:id])

    # id = params[:id]

    # TODO - add search by username
    user = User.includes(comments: :post).find(params[:id])
    # user = User.where("id = ? OR username = ?", id, id).includes(comments: :post).first

    @user = UserDecorator.new(user)
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
    current_user.follow @user
    redirect_to @user, notice: "You are now following #{@user.username}."
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow @user
    redirect_to @user, notice: "You are not ollowing #{@user.username} anymore."
  end

end
