class TournamentDaysController < ApplicationController

  def index
    render json: { tournament_days: TournamentDay.by_days(current_user) }
  end

end
