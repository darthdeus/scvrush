class RaffleSignupsController < ApplicationController
  before_filter :require_login

  def create
    @raffle = Raffle.find(params[:id])
    @raffle.register(current_user)
    redirect_to @raffle, notice: "You have successfully join the raffle!"
  end

end
