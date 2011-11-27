class UsersController < ApplicationController
  before_filter :require_login, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.username      = params[:user][:username]
    @user.email         = params[:user][:email]
    @user.bnet_username = params[:user][:bnet_username]
    @user.bnet_code     = params[:user][:bnet_code]
    if @user.save
      redirect_to @user, :notice => "Your profile was successfully updated."
    else
      render 'edit'
    end    
  end

end
