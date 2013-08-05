class TournamentsController < AuthenticatedController

  def index
    @grouped_tournaments = Tournament.order("starts_at DESC").limit(20).group_by { |tournament| tournament.starts_at.to_date }
    @calendar_tournaments = Tournament.order("starts_at DESC")
                                        .where("created_at > ?", 1.month.ago)
                                        .group_by { |tournament| tournament.starts_at.to_date }
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = current_user.tournaments.build(params[:tournament])
    @tournament.tournament_type = "User"
    @tournament.bo_preset = "1"

    if @tournament.save
      flash[:notice] = "Tournament was created."
      redirect_to @tournament
    else
      render :new
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    authorize! :edit, @tournament

    if @tournament.update_attributes(params[:tournament])
      redirect_to @tournament
    else
      render :edit
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    if current_user.tournament_admin?
      @tournament.destroy
      redirect_to tournaments_path, notice: "Tournament was deleted"
    else
      redirect_to @tournament, notice: "You're not authorized to delete this tournament."
    end
  end


  def seed
    tournament = TournamentDecorator.find(params[:id])
    authorize! :seed, tournament

    bracket = Bracket.new(tournament)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    tournament.seeded = true
    tournament.save!

    flash[:notice] = "Tournament was seeded"
    redirect_to tournament
  end

  def destroy_seed
    tournament = TournamentDecorator.find(params[:id])
    authorize! :seed, tournament

    tournament.seeded = false
    tournament.winner = nil
    tournament.rounds.destroy_all

    tournament.save!

    flash[:notice] = "Tournament seed was deleted"
    redirect_to tournament
  end

  def checked_trial_players
    @tournament = Tournament.find(params[:id])
  end

  def matches
    @tournament = Tournament.find(params[:id])
  end

  def start
    tournament = Tournament.find(params[:id])
    authorize! :start, tournament

    unless tournament.started?
      tournament.start
    end

    redirect_to tournament
  end

  def randomize
    users = User.where("bnet_username IS NOT NULL").limit(10)
    tournament = Tournament.find(params[:id])
    tournament.users = users
    tournament.users << current_user
    tournament.users.each { |u| u.check_in(tournament) }

    redirect_to tournament
  end

end
