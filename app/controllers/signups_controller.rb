class SignupsController < ApplicationController
  before_filter :require_login
  before_filter :require_bnet_username

  def create
    @signup = Signup.new
    @signup.user = current_user
    @tournament = Tournament.find(params[:id])
    @signup.tournament = @tournament
    @signup.status = Signup::REGISTERED
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

  protected
  
  def require_bnet_username
    unless current_user.has_bnet_username?
      redirect_to edit_user_path(current_user), :notice => "You can't participate in a tournament unless you fill in your Battle.net username and code."
    end
  end

end
