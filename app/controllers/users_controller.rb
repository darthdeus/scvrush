class UsersController < AuthenticatedController

  def index
    @users = User.limit(15).decorate
  end

  def show
    @user = User.find(params[:id]).decorate
  end

  def edit
    @user = User.find(params[:id])
  end

end
