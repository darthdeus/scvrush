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

    match = bracket.current_match_for(current_user)
    bracket.set_score_for(current_user, params[:score], false, params[:opponent_id])

    match.reload

    match.winner.statuses.create!(text: "I've just advanced against #{match.loser.bnet_info} in #{match.matchup(match.winner)} in #{match.round.human_name}")
    match.loser.statuses.create!(text: "I've just lost against #{match.loser.bnet_info} in #{match.matchup(match.loser)} and I'm out of #{match.round.human_name} :(")

    bracket.seed_next_match_with(match.winner, match)

    render json: match, serializer: TournamentAdminMatchReportSerializer, scope: current_user
  rescue Bracket::AlreadySubmitted
    render json: { error: "You can't change the match result. Please contact any of the tournament admins if the result is incorrect." }
  rescue Bracket::NotStartedYet
    render json: { error: "You can't submit a match result before you have an opponent" }
  end

  def show
    render json: Match.find(params[:id])
  end

  def update
    match = Match.find(params[:id])
    match.score = params[:match][:score]

    bracket = Bracket.new(match.round.tournament)

    if match.save
      bracket.seed_next_match_with(match.winner, match)

      render json: match, serializer: TournamentAdminMatchReportSerializer
    else
      raise ActiveRecord::RecordInvalid, "Invalid match, this shouldn't happen"
    end
  end

  def destroy
    @match = Match.find(params[:id])
    bracket.reset_match(@match)
  end

end
