class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update]

  def index
    redirect_to new_user_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: "Signed up!"
    else
      render "new"
    end
  end

  def show
    @user = User.includes(comments: :post).find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    if @user.save
      redirect_back_or @user, notice: "Your profile was successfully updated."
    else
      render 'edit'
    end
  end

end
