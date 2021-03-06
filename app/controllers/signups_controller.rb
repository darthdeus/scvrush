class SignupsController < AuthenticatedController
  # before_filter :require_bnet_username

  def index
    @tournament = Tournament.find(params[:tournament_id])
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @signup = Signup.for(current_user, @tournament)

    current_user.bnet_info = params[:bnet_info]
    current_user.race = params[:race]
    current_user.skip_email_validation = true
    current_user.save!

    registrator = UserRegistrator.new(@signup)
    message = registrator.forward

    flash[:notice] = message

    redirect_to @tournament
  end

  def destroy
    tournament = Tournament.find(params[:tournament_id])
    if params[:admin]
      authorize! :manage, Tournament
      signup = tournament.signups.find(params[:id])
      tournament.unregister(signup.user)

      redirect_to signups_tournament_path(tournament), notice: "Signup was deleted."
    else
      tournament.unregister(current_user)
      redirect_to tournament, notice: "Your registration was canceled. We're sorry to see you go."
    end
  end

  def add_user
    authorize! :manage, Tournament
    tournament = Tournament.find(params[:tournament_id])

    if params[:user]
      flash[:notice] = "User was added to the tournament"

      id = params[:user][/\A\d+/]
      user = User.find(id)

      signup = Signup.for(user, tournament)
      signup.register
    else
      flash[:error] = "User string required"
    end

    redirect_to signups_tournament_path(tournament)
  end

  def check_in_user
    authorize! :manage, Tournament
    signup = Signup.find(params[:id])
    signup.checkin

    redirect_to signups_tournament_path(signup.tournament), notice: "User was checked in."
  end

  protected

  def require_bnet_username
    if !current_user.bnet_info.present? || !current_user.race.present?
      session[:redirect_back] = env["HTTP_REFERER"]
      redirect_to edit_user_path(current_user), notice: "You can't participate in a tournament unless you fill in your Battle.net username and code."
    end
  end

end
