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
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Signed up!"
    else
      render "new"
    end
  end

  def show
    # @user = User.where("id = ? OR username = ?", params[:id],
    # params[:id]).includes(comments: :post)



    # @user = User.find(params[:id])

    # @user = User.find_by_username_or_id(params[:id])
    id = params[:id]
    @user = User.where("id = ? OR username = ?", id, id).includes(comments: :post).first
    gon.user_id = id
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

end
