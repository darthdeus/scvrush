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

      BRACKET_LOG.info "#{current_user.to_debug} submitted score #{params[:score]} against #{params[:opponent_id]}"

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

  def edit
    @match = Match.find(params[:id])
  end

  def update
    match = Match.find(params[:id])
    match.score = params[:match][:score]
    match.player1_id = params[:match][:player1_id]
    match.player2_id = params[:match][:player2_id]

    bracket = Bracket.new(match.round.tournament)

    BRACKET_LOG.info "#{current_user.to_debug} updated match #{match.id} with params #{params.to_json}"
    if match.save
      BRACKET_LOG.info "SUCCESS"

      bracket.seed_next_match_with(match.winner, match)

      redirect_to tournament_path(match.tournament, admin_view: 1)
    else
      BRACKET_LOG.info "FAILED"

      raise ActiveRecord::RecordInvalid, "Invalid match, this shouldn't happen"
    end
  end

end
