class RoundsController < ApplicationController
  before_filter :require_login, except: [:index]

  respond_to :json

  def index
    @tournament = Tournament.find(params[:tournament_id])
    # TODO - display the last round too
    rounds = @tournament.rounds[0..-2].map(&:to_simple_json)
    render json: rounds
  end


  def edit
    authorize! :manage, Round
    @round = Round.find(params[:id])
  end

  def update
    @round = Round.find(params[:id])
    if @round.update_attributes(params[:round])
      redirect_to @round.tournament, notice: "Round was updated"
    else
      render :edit
    end
  end
end
