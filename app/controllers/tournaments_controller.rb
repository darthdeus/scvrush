class TournamentsController < ApplicationController

  respond_to :json

  def index
    if params[:ids]
      respond_with Tournament.find(params[:ids])
    end
  end

  def create
    tournament = Tournament.new
    tournament.name = params[:tournament][:name]
    tournament.starts_at = params[:tournament][:starts_at]
    tournament.max_players = params[:tournament][:max_players]

    tournament.tournament_type = Tournament.types[:user]
    tournament.user = current_user
    tournament.bo_preset = "1"

    tournament.save

    respond_with tournament
  end

  def show
    respond_with Tournament.find(params[:id])
  end

  def destroy
    tournament = Tournament.find(params[:id])
    tournament.destroy

    render json: tournament
  end

  def update
    tournament = Tournament.find(params[:id])

    if params[:tournament][:is_registered]
      registrator = UserRegistrator.new(current_user, tournament)
      registrator.signup
    elsif params[:tournament][:is_checked]
      registrator = UserRegistrator.new(current_user, tournament)
      registrator.checkin
    else
      tournament.unregister(current_user)
    end

    # TODO - check user
    if params[:tournament][:starts_at]
      tournament.update_attributes(params[:tournament].extract!(:starts_at, :name))
    end

    # TODO - check impl of respond_with, since it returns 204 instead of 200
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

    if tournament.started?
      # TODO - figure out a better way to handle this
      raise "Tournament was already started"
    else
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
