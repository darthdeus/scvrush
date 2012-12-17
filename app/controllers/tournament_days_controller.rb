class TournamentDaysController < ApplicationController

  def index
    render json: TournamentDay.by_days
  end

end
