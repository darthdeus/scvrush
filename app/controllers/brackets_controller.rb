class BracketsController < ApplicationController

  def create
    tournament = Tournament.find(params[:bracket][:tournament_id])
    bracket = Bracket.new(tournament)
    bracket.create_bracket_rounds
    bracket.create_matches
    bracket.linear_seed

    tournament.seeded = true
    tournament.save!

    s = TournamentSerializer.new(tournament)
    render json: s.as_json(include_root: false).merge(bracket: bracket.to_json)
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
