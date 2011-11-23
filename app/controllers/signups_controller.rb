class SignupsController < ApplicationController
  before_filter :require_login

  def create
    @signup = Signup.new
    @signup.user = current_user
    @tournament = Tournament.find(params[:id])
    @signup.tournament = @tournament
    @signup.save!
    redirect_to @tournament, :notice => "You have successfuly registered to the tournament."
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @signup = @tournament.signups.where(:user_id => current_user.id)
    @signup.destroy_all
    redirect_to @tournament, :notice => "You've been signed out."
  end

  def update
    @tournament = Tournament.find(params[:id])
    current_user.check_in(@tournament)
    redirect_to @tournament, :notice => "You've been checked in! Enjoy the tournament."
  end

end
