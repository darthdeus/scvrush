class MatchesController < ApplicationController
  respond_to :json

  def index
    if params[:ids]
      render json: Match.find(params[:ids])
    elsif params[:tournament_id]
      render json: Tournament.find(params[:tournament_id]).matches
    else
      raise ArgumentError, "Invalid params for matches"
    end
    # authorize! :manage, Match
    # @matches = Match.limit(20).order("updated_at DESC")
  end

  def create
    bracket = Bracket.with_tournament(params[:tournament_id])

    unless params[:score].present?
      flash[:error] = "You can't submit an empty match result"
      redirect_to bracket.tournament and return
    end

    match = bracket.current_match_for current_user
    # TODO - use hash instead of an id
    winner = bracket.set_score_for(current_user, params[:score], false, params[:opponent_id])

    # FIXME - this is never met
    # if winner == current_user
    #   flash[:success] = "Congratulations, you won the tournament!"
    # else
    #   flash[:success] = "Match result was submitted"
    # end

    render json: bracket.tournament.matches.reload
    # TODO - don't use flash messages for this
  rescue Bracket::AlreadySubmitted
    render json: { error: "You can't change the match result. Please contact any of the tournament admins if the result is incorrect." }
  rescue Bracket::NotStartedYet
    render json: { error: "You can't submit a match result before you have an opponent" }
  end

  def show
    render json: Match.find(params[:id])
  end

  def edit
    authorize! :manage, Match
    @match = Match.find(params[:id])
    @players = @match.round.tournament.registered_players
  end

  def update
    match = Match.find(params[:id])
    match.score = params[:match][:score]

    bracket = Bracket.new(match.round.tournament)

    if match.save
      bracket.seed_next_match_with(match.winner, match)

      render json: match.round.tournament, serializer: TournamentMatchReportSerializer
      # tournament_json = TournamentSerializer.new(match.round.tournament, scope: current_user)
      # matches_json = MatchSerializer.new(match.round.tournament.matches, scope: current_user)

      # render json: {
      #   matches: [matches_json.as_json(root: false)],
      #   tournaments: [tournament_json.as_json(root: false)]
      # }
    else
      raise ActiveRecord::RecordInvalid, "Invalid match, this shouldn't happen"
    end
  end

  def destroy
    @match = Match.find(params[:id])
    bracket.reset_match(@match)
  end

end
