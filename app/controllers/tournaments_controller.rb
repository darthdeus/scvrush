class TournamentsController < ApplicationController
  # TODO - change to admin
  before_filter :require_writer, only: [:edit, :update, :create, :new]
  layout "single"

  def index
    data = Tournament.order("created_at DESC").page(params[:page])
    @tournaments = TournamentDecorator.decorate(data)
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      redirect_to @tournament, notice: "You've successfuly created a tournament."
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html do
        @tournament = TournamentDecorator.find(params[:id])
        gon.tournament_id = @tournament.id
        @user = TournamentPlayerDecorator.new(current_user, @tournament)
        if @tournament.started?
          @bracket = Bracket.new(@tournament)

          render :show
        else
          # redirecting here will drop the flash message
          render :signup
        end
      end

      format.json do
        @tournament = Tournament.find(params[:id])
        rounds = @tournament.rounds.map(&:to_simple_json)
        render json: rounds
      end
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    @winner = @tournament.users.find(params[:tournament][:winner])
    @tournament.set_winner(@winner)

    flash[:notice] = "Tournament winner was set successfuly"
    redirect_to controller: :dashboard, action: :index
  end

  def seed
    tournament = TournamentDecorator.find(params[:id])

    bracket = Bracket.new(tournament)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    tournament.seeded = true
    tournament.save!

    flash[:success] = "The tournament was seeded properly"
    redirect_to tournament
  end

  def unseed
    tournament = TournamentDecorator.find(params[:id])
    tournament.seeded = false
    tournament.rounds.destroy_all
    tournament.save!

    flash[:success] = "The seed was destroyed. Please seed the tournament again before players can submit their match results"
    redirect_to tournament
  end

end
