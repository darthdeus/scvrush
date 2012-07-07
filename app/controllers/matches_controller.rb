class MatchesController < ApplicationController
  def create
    tournament = Tournament.find(params[:tournament_id])
    bracket = Bracket.new(tournament)

    match = bracket.current_match_for(current_user)
    match.set_score_for(current_user, params[:score])
    # TODO - display possible erroe messages
    match.save!

    flash[:success] = "Match result was submitted"
    redirect_to tournament
  end
end
