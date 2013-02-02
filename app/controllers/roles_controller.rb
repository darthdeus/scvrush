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
    change_role(params, params[:role], :grant)
  end

  def destroy
    authorize! :manage, Role
    change_role(params, params[:id], :revoke)
  end

  private

  def change_role(params, role, action)
    @user = User.find(params[:user_id])
    @user.send(action, role)
    redirect_to roles_path(search: params[:search]), notice: "User #{@user.username} was #{action.to_s}ed #{params[:role]} role."
  end

end
