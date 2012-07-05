class TournamentsController < ApplicationController
  # TODO - change to admin
  before_filter :require_writer, only: [:edit, :update]
  layout "single"

  def index
    @tournaments = Tournament.page(params[:page])
  end

  def show
    respond_to do |format|
      format.html do
        @tournament = TournamentDecorator.find(params[:id])
        @user = TournamentPlayerDecorator.new(current_user, @tournament)
        if @tournament.started?
          @bracket = Bracket::Bracket.new(@tournament.users).to_json
          render :show
        else
          # redirecting here will drop the flash message
          render :signup
        end
      end

      format.json do
        render json: Tournament.random_info
      end
    end
  end

  def signup
    @tournament = TournamentDecorator.find(params[:id])
    @user = TournamentPlayerDecorator.new(current_user, @tournament)
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

end
