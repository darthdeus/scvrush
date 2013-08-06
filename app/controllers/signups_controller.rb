class SignupsController < AuthenticatedController
  before_filter :require_bnet_username

  def index
    @tournament = Tournament.find(params[:tournament_id])
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @signup = Signup.for(current_user, @tournament)
    if @signup.signup!
      flash[:notice] = "You have successfuly registered to the tournament."
    else
      flash[:success] = "You can't register for a given tournament"
    end

    redirect_to @tournament
  end

  def update
    @tournament = Tournament.find(params[:tournament_id])
    @user = TournamentPlayerDecorator.new(current_user, @tournament)
    if @user.registered?
      current_user.check_in(@tournament)
      flash[:notice] = "You've been checked in! Enjoy the tournament."
    else
      flash[:notice] = "You can't check in because you're not registered. Please contact the tournament administrator."
    end
    redirect_to @tournament
  end

  def destroy
    @tournament = Tournament.find(params[:tournament_id])
    @tournament.unregister(current_user)
    redirect_to @tournament, notice: "Your registration was canceled. We're sorry to see you go."
  end

  protected

  def require_bnet_username
    if !current_user.bnet_info.present? || !current_user.race.present?
      session[:redirect_back] = env["HTTP_REFERER"]
      redirect_to edit_user_path(current_user), notice: "You can't participate in a tournament unless you fill in your Battle.net username and code."
    end
  end

end
