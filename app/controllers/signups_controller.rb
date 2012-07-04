class SignupsController < ApplicationController
  before_filter :require_login
  before_filter :require_bnet_username

  def create
    @tournament = Tournament.find(params[:id])
    @signup = Signup.for(current_user, @tournament)
    if @signup.signup
      flash[:notice] = "You have successfuly registered to the tournament."
    else
      flash[:success] = "You can't register for a given tournament"
    end
    redirect_to signup_tournament_path(@tournament)
  end

  def update
    @tournament = Tournament.find(params[:id])
    if current_user.registered_for? @tournament
      current_user.check_in(@tournament)
      flash[:notice] = "You've been checked in! Enjoy the tournament."
    else
      flash[:notice] = "You can't check in because you're not registered. Please contact the tournament administrator."
    end
    redirect_to signup_tournament_path(@tournament)
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.unregister(current_user)
    flash[:notice] = "Your registration was canceled, we are sorry to see you go."
    redirect_to signup_tournament_path(@tournament)
  end

  protected

  def require_bnet_username
    unless current_user.has_bnet_username?
      session[:redirect_back] = env["HTTP_REFERRER"]
      redirect_to edit_user_path(current_user), notice: "You can't participate in a tournament unless you fill in your Battle.net username and code."
    end
  end

end
