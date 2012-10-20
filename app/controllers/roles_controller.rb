class RolesController < ApplicationController
  def index
    authorize! :manage, Role
    @users = UserSearch.search(params[:search]).page(params[:page])
  end

  def with_roles
    authorize! :manage, Role
    users = UserSearch.search(params[:search]).page(params[:page])
    @users = users.includes(:roles).reject { |u| u.roles.empty? }
    render :index
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
