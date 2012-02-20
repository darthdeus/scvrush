class RolesController < ApplicationController
  def index
    authorize! :manage, Role
    if params[:search].present?
      @users = User.where('username LIKE ? OR bnet_username LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page])
    else
      @users = User
    end
    if params[:with_roles] == '1'
      @users = @users.includes(:roles).reject { |u| u.roles.empty? }
    else
      @users = @users.page(params[:page])
    end
  end

  def create
    authorize! :manage, Role
    @user = User.find(params[:user_id])
    @user.grant params[:role]

    redirect_to roles_path(search: params[:search]), notice: "User #{@user.username} was granted #{params[:role]} role."
  end

  def destroy
    authorize! :manage, Role
    @user = User.find(params[:user_id])
    @user.revoke params[:id]

    redirect_to roles_path(search: params[:search]), notice: "User #{@user.username} was revoked #{params[:id]} role."
  end
end
