class BracketsController < ApplicationController

  def update
    tournament = Tournament.find(params[:id])
    bracket = Bracket.new(tournament)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    tournament.seeded = true
    tournament.save!

    render json: TournamentSerializer.new(tournament)
  end

  def destroy
    tournament = TournamentDecorator.find(params[:id])
    # authorize! :seed, tournament

    tournament.seeded = false
    tournament.winner = nil
    tournament.rounds.destroy_all

    tournament.save!

    render json: TournamentSerializer.new(tournament)
  end

end
