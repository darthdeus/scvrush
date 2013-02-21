class TournamentsController < ApplicationController

  respond_to :json

  def index
    if params[:ids]
      respond_with Tournament.find(params[:ids])
    end
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

    # FIXME - figure out what is the correct response here since ember doesn't care about 204
    respond_with tournament
    # render json: {}, status: :ok
  end

  def update
    tournament = Tournament.find(params[:id])

    if params[:tournament][:is_checked]
      registrator = UserRegistrator.new(current_user, tournament)
      registrator.checkin
    elsif params[:tournament][:is_registered]
      registrator = UserRegistrator.new(current_user, tournament)
      registrator.signup
    elsif !params[:tournament][:is_checked] && !params[:tournament][:is_registered]
      tournament.unregister(current_user)
    end

    if params[:tournament][:starts_at]
      tournament.update_attributes(params[:tournament].extract!(:starts_at, :name))
    end

    render json: tournament
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
