class MatchesController < ApplicationController
  def create
    tournament = Tournament.find(params[:tournament_id])
    bracket = Bracket.new(tournament)

    bracket.set_score_for(current_user, params[:score])
    # TODO - display possible error messages

    flash[:success] = "Match result was submitted"
    redirect_to tournament
  end
end
