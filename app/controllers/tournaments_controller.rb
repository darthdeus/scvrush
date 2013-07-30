class TournamentsController < AuthenticatedController

  def index
    @grouped_tournaments = Tournament.order("starts_at DESC").limit(20).group_by { |tournament| tournament.starts_at.to_date }
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

end
