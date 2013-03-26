class RoundsController < ApplicationController

  respond_to :json

  def index
    if params[:ids]
      rounds = Round.find(params[:ids])
    else
      # TODO - display the last round too
      tournament = Tournament.find(params[:tournament_id])
      rounds = tournament.rounds[0..-2].map(&:to_simple_json)
    end

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
