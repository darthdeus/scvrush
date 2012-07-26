class MatchesController < ApplicationController
  before_filter :require_login

  def index
    authorize! :manage, Match
    @matches = Match.limit(20).order("updated_at DESC")
  end

  def create
    tournament = Tournament.find(params[:tournament_id])
    bracket = Bracket.new(tournament)

    unless params[:score].present?
      flash[:error] = "You can't submit an empty match result"
      redirect_to tournament and return
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

    redirect_to tournament
  end


  def edit
    authorize! :manage, Match
    @match = Match.find(params[:id])
    @players = @match.round.tournament.registered_players
  end

  def update
    authorize! :manage, Match
    @match = Match.find(params[:id])

    @match.player1_id = params[:match][:player1_id]
    @match.player2_id = params[:match][:player2_id]

    @match.score = params[:match][:score]


    if @match.save
      if !@match.player1_id? && !@match.player2_id?
        @match.score = nil
        @match.save!
      end

      bracket = Bracket.new(@match.round.tournament)
      bracket.seed_next_match_with(@match.winner, @match)

      redirect_to @match.round.tournament, notice: "Match results were updated"
    else
      @players = @match.round.tournament.registered_players
      render :edit
    end
  end

  def destroy
    @match = Match.find(params[:id])
    bracket.reset_match(@match)
  end

end
