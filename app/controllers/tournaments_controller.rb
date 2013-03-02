class TournamentsController < ApplicationController

  respond_to :json

  def index
    if params[:ids]
      respond_with Tournament.find(params[:ids]) and return
    end

    tournaments = Tournament.scoped

    if params[:query].present?
      tournaments = tournaments.search(params[:query], page: params[:page] || 1, load: true)
    elsif params[:page]
      tournaments = tournaments.page(params[:page]).per(50)
    else
      tournaments = tournaments.order("created_at DESC").limit(20)
    end

    render json: tournaments.to_a
  end

  def create
    tournament = Tournament.factory(params[:tournament], current_user)
    tournament.save

    respond_with tournament
  end

  def show
    respond_with Tournament.find(params[:id])
  end

  def destroy
    tournament = Tournament.find(params[:id])
    tournament.destroy

    respond_with tournament
  end

  # TODO - match submission should be extracted into a separate action
  def update
    tournament = Tournament.find(params[:id])
    status = nil

    if params[:tournament][:is_checked]
      registrator = UserRegistrator.new(current_user, tournament)
      signup = registrator.checkin

      status = registrator.post_status(signup)
    elsif params[:tournament][:is_registered]
      registrator = UserRegistrator.new(current_user, tournament)
      signup = registrator.signup

      status = registrator.post_status(signup)
    elsif !params[:tournament][:is_checked] && !params[:tournament][:is_registered]
      tournament.unregister(current_user)
    end

    if params[:tournament][:starts_at]
      tournament.update_attributes(params[:tournament].extract!(:starts_at, :name))
    end

    if status
      render json: {
        tournament: TournamentSerializer.new(tournament.reload, scope: current_user).as_json(root: false),
        statuses: [StatusSerializer.new(status, scope: current_user).as_json(root: false)]
      }
    else
      render json: tournament
    end
  end

  def seed
    tournament = TournamentDecorator.find(params[:id])

    bracket = Bracket.new(tournament)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    tournament.seeded = true
    tournament.save!

    render json: tournament.reload
  end

  def unseed
    tournament = TournamentDecorator.find(params[:id])

    tournament.seeded = false
    tournament.winner = nil
    tournament.rounds.destroy_all

    tournament.save!

    render json: tournament.reload
  end

  def start
    tournament = Tournament.find(params[:id])
    # authorize! :start, tournament

    unless tournament.started?
      tournament.start
    end

    render json: tournament.reload
  end

  def randomize
    users = User.where("bnet_username IS NOT NULL").limit(10)
    tournament = Tournament.find(params[:id])
    tournament.users = users
    tournament.users << current_user
    tournament.users.each { |u| u.check_in(tournament) }

    respond_with tournament.reload
  end

end
