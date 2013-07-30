class MatchesController < AuthenticatedController

  def create
    bracket = Bracket.with_tournament(params[:tournament_id])

    unless params[:score].present?
      flash[:error] = "You can't submit an empty match result"
      redirect_to bracket.tournament and return
    end

    begin
      # TODO - use hash instead of an id
      winner = bracket.set_score_for(current_user, params[:score], false, params[:opponent_id])

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

    redirect_to bracket.tournament
  end

end
