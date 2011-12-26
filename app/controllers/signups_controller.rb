class SignupsController < ApplicationController
  before_filter :require_login
  before_filter :require_bnet_username

  def create
    @tournament = Tournament.find(params[:id])
    current_user.sign_up(@tournament)
    redirect_to @tournament, :notice => "You have successfuly registered to the tournament."
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.unregister(current_user)
    redirect_to @tournament, :notice => "You've been signed out."
  end

  def update
    @tournament = Tournament.find(params[:id])
    current_user.check_in(@tournament)
    redirect_to @tournament, :notice => "You've been checked in! Enjoy the tournament."
  end

  protected

  def require_bnet_username
    unless current_user.has_bnet_username?
      redirect_to edit_user_path(current_user), :notice => "You can't participate in a tournament unless you fill in your Battle.net username and code."
    end
  end

end
