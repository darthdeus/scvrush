class MatchesController < ApplicationController
  def create
    tournament = Tournament.find(params[:tournament_id])
    bracket = Bracket.new(tournament)

    winner = bracket.set_score_for(current_user, params[:score])
    if winner == current_user
      flash[:success] = "Congratulations, you won the tournament!"
    else
      flash[:success] = "Match result was submitted"
    end
    # TODO - display possible error messages

    redirect_to tournament
  end
end
