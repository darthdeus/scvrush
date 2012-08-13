class TournamentsController < ApplicationController
  before_filter :require_login, only: [ :new, :create, :seed, :unseed, :start, :edit, :update ]

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
    @tournament.tournament_type = Tournament.types[:user]
    @tournament.user = current_user
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

          @current_match = @bracket.current_match_for(@user)
          if @current_match
            @lost = @current_match.loser?(@user)
            @next_opponent = @current_match.opponent_for(@user)
          end

          gon.is_admin = Ability.new(current_user).can?(:manage, Match)

          render :show
        else
          # redirecting here will drop the flash message
          render :signup
        end
      end

      format.json do
        @tournament = Tournament.find(params[:id])
        # TODO - display the last round too
        rounds = @tournament.rounds[0..-2].map(&:to_simple_json)
        render json: rounds
      end
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
    authorize! :edit, @tournament
  end

  def update
    @tournament = Tournament.find(params[:id])
    authorize! :update, @tournament

    # TODO - protect from setting the type here
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Tournament winner was set successfuly"
      redirect_to edit_tournament_path(@tournament)
    else
      render :edit
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

end
