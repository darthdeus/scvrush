class Api::TournamentsController < ApplicationController
  respond_to :json

  def index
    if params[:league]
      t =  Tournament.where("starts_at > ? AND leagues LIKE ?", Time.now, "%#{params[:league].titleize}%").first
      render json: [t]
      return
    end

    if params[:ids]
      render json: Tournament.find(params[:ids]) and return
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

    render json: tournament
  end

  def show
    render json: Tournament.find(params[:id])
  end

  def destroy
    tournament = Tournament.find(params[:id])
    tournament.destroy

    render json: {}
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
      attributes = params[:tournament].extract!(:starts_at, :name, :bo_preset, :map_preset)
      tournament.update_attributes(attributes)
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

    render json: tournament.reload
  end

end
