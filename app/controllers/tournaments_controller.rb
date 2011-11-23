class TournamentsController < ApplicationController
  def show
    @tournament = Tournament.find(params[:id])
    @registered_users = @tournament.signups.registered
    @checked_users = @tournament.signups.checked
  end

end
