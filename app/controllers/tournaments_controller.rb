class TournamentsController < ApplicationController
  before_filter :require_login, only: [ :new, :create, :seed, :unseed, :start, :edit, :update, :emails ]

  respond_to :json

  def index
    if params[:ids]
      respond_with Tournament.find(params[:ids])
    end
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    @tournament.tournament_type = Tournament.types[:user]
    @tournament.user = current_user
    if @tournament.save
      redirect_to @tournament, notice: "You've successfuly created a tournament."
    else
      render :new
    end
  end

  def show
    respond_with Tournament.find(params[:id])
  end

  def rounds
    @tournament = Tournament.find(params[:id])
    # TODO - display the last round too
    rounds = @tournament.rounds[0..-2].map(&:to_simple_json)
    render json: rounds
  end

  def edit
    @tournament = Tournament.find(params[:id])
    authorize! :edit, @tournament
  end

  def update
    tournament = Tournament.find(params[:id])
    if params[:tournament][:is_registered]
      signup = Signup.for(current_user, tournament)
      signup.signup!
    else
      tournament.unregister(current_user)
    end

    render json: { tournament: tournament.as_json(user: current_user) }

    # authorize! :update, @tournament

    # # TODO - protect from setting the type here
    # if @tournament.update_attributes(params[:tournament])
    #   flash[:notice] = "Tournament was updated successfuly."
    #   redirect_to @tournament
    # else
    #   render :edit
    # end
  end

  def seed
    tournament = TournamentDecorator.find(params[:id])
    authorize! :seed, tournament

    bracket = Bracket.new(tournament)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    tournament.seeded = true
    if tournament.save
      flash[:success] = "The tournament was seeded properly"
    else
      flash[:error] = "The tournament wasn't created properly"
    end
    redirect_to tournament
  end

  def unseed
    tournament = TournamentDecorator.find(params[:id])
    authorize! :seed, tournament

    tournament.seeded = false
    tournament.winner = nil
    tournament.rounds.destroy_all

    if tournament.save
      flash[:success] = "The seed was destroyed. Please seed the tournament again before players can submit their match results"
    else
      flash[:error] = "The tournament wasn't created properly"
    end

    redirect_to tournament
  end

  def matches
    @tournament = TournamentDecorator.find(params[:id])
    @matches = @tournament.matches.where("score IS NOT NULL")
  end

  def start
    @tournament = Tournament.find(params[:id])
    authorize! :start, @tournament

    if @tournament.started?
      flash[:error] = "Tournament was already started."
    else
      @tournament.start
      flash[:success] = "Tournament was started."
    end

    redirect_to @tournament
  end

  def emails
    @tournament = TournamentDecorator.find(params[:id])
    if current_user.has_role? :tournament_admin, @tournament
      render text: @tournament.checked_players.map(&:email).join("<br>")
    else
      flash[:error] = "Access denied! Only tournament administrators can view emails."
      redirect_to root_path
    end
  end

end
