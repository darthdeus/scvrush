class TournamentsController < ApplicationController
  def show
    @tournament = Tournament.find(params[:id])
  end

end
