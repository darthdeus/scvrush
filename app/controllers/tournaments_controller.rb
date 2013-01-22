class TournamentsController < ApplicationController
  before_filter :require_login, only: [ :new, :create, :seed, :unseed, :start, :edit, :update, :emails ]

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

  def destroy
    @tournament = current_user.tournaments.find(params[:id])
    @tournament.destroy
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

    # TODO - check impl of respond_with, since it returns 204 instead of 200
    render json: tournament
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

    respond_with tournament
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
      # TODO - figure out a better way to handle this
      raise "Tournament was already started"
    else
      @tournament.start
    end

    respond_with @tournament
  end

end
