class TournamentsController < ApplicationController
  # TODO - change to admin
  before_filter :require_writer, except: [:index, :show]
  layout "single"

  def index
    @tournaments = Tournament.page(params[:page])

  end

  def show
    @tournament = Tournament.find(params[:id])
    @ro32 = @tournament.users.all
    @ro16 = @ro32.select.with_index { |player, index| index.even? }
    @ro8  = @ro16.select.with_index { |player, index| index.even? }
    @ro4  = @ro8.select.with_index { |player, index| index.even? }
    @ro2  = @ro4.select.with_index { |player, index| index.even? }
    @bracket = Bracket::Bracket.new(@tournament.users).to_json
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
