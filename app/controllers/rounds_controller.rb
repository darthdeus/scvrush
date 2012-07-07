class RoundsController < ApplicationController
  before_filter :require_login

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
