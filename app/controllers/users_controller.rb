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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: "Your profile was updated"
    else
      render :edit
    end
  end

  def activate
    user = User.find(params[:id])
    raise "User activation seems to be broken" unless user == current_user

    user.race = params[:race] if params[:race].present?
    user.league = params[:league] if params[:league].present?
    user.server = params[:server] if params[:server].present?
    user.save(validate: false)

    redirect_to new_activation_path
  end

end
