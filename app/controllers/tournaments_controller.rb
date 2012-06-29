class TournamentsController < ApplicationController
  # TODO - change to admin
  before_filter :require_writer, except: [:index, :show]
  layout "single"

  def index
    @tournaments = Tournament.page(params[:page])
  end

  def show
    @tournament = Tournament.find(params[:id])
    @registered_users = @tournament.signups.registered
    @checked_users = @tournament.signups.checked
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
