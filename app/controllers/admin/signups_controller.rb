module Admin
  class SignupsController < ApplicationController

    layout "admin"

    before_filter :assign_tournament

    def index
      @signups = @tournament.signups
    end

    def update
      @signup = @tournament.signups.find(params[:id])
      if params[:checkin] == "true"
        @signup.checkin!
        flash[:success] = "User was checked in."
      else
        @signup.cancel_checkin
        flash[:success] = "Checkin was canceled."
      end

      redirect_to :back
    end

    def destroy
      signup = @tournament.signups.find(params[:id])
      signup.destroy
      flash[:success] = "Signup was deleted."
      redirect_to :back
    end

    protected

    def assign_tournament
      @tournament = Tournament.find(params[:tournament_id])
      authorize! :tournament_admin, @tournament
    end
  end

end
