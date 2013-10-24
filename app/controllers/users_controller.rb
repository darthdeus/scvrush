class UsersController < AuthenticatedController

  def index
    if params[:query].present?
      @users = User.search(params[:query], load: true)
    else
      @users = User.limit(15)
    end
  end

  def show
    if params[:username]
      redirect_to user_path(params[:username])
    else
      @user = User.find_by_username(params[:id])
      if !@user
        redirect_to users_path(User.find(params[:id]).username)
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile was updated."
      redirect_back_or @user
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

  def follow
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_to :back
  end

  def unfollow
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to :back
  end

end
