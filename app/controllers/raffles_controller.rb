class RafflesController < ApplicationController

  def new
    authorize! :manage, Raffle
    @raffle = Raffle.new
  end

  def create
    authorize! :manage, Raffle
    @raffle = Raffle.new(params[:raffle])
    if @raffle.save
      redirect_to @raffle, :notice => "Raffle succesfuly created"
    else
      render "new"
    end
  end

  def edit
    authorize! :manage, Raffle
    @raffle = Raffle.find(params[:id])
  end

  def update
    authorize! :manage, Raffle
    @raffle = Raffle.find(params[:id])
    @raffle.update_attributes(params[:raffle])
    if @raffle.save
      redirect_to @raffle, :notice => "Raffle was updated"
    else
      render "edit"
    end
  end

  def destroy
    authorize! :manage, Raffle
    Raffle.destroy(params[:id])
    redirect_to '/dashboard/index', :notice => "Raffle was removed"
  end

  def index
    @raffles = Raffle.all
  end

  def show
    @raffle = Raffle.find(params[:id])
  end

  def close
    authorize! :manage, Raffle
    @raffle = Raffle.find(params[:id])
    @raffle.calculate_winner
    redirect_to @raffle, :notice => "Raffle was closed and the winner was selected"
  end

end
