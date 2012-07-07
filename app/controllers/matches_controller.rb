class MatchesController < ApplicationController
  def create
    tournament = Tournament.find(params[:tournament_id])
    bracket = Bracket.new(tournament)

    begin
      winner = bracket.set_score_for(current_user, params[:score])

      if winner == current_user
        flash[:success] = "Congratulations, you won the tournament!"
      else
        flash[:success] = "Match result was submitted"
      end

    rescue Bracket::AlreadySubmitted
      flash[:error] = "You can't change the match result. Please contact any of the tournament admins if the result is incorrect."
    rescue Bracket::NotStartedYet
      flash[:error] = "You can't submit a match result before you have an opponent"
    end
    # TODO - display possible error messages

    redirect_to tournament
  end
end
