class StatusesController < ApplicationController

  before_filter :require_login, except: [:index]
  respond_to :json

  def index
    @user = User.find(params[:user_id])
    respond_with @user.timeline_statuses.as_json(user: current_user)
  end

  def create
    @status = current_user.statuses.create(params[:status])
    respond_with @status, location: nil
  end

  def destroy
    @user = User.find(params[:user_id])
    @status = @user.statuses.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def upvote
    user = User.find(params[:user_id])
    voter = VoterDecorator.new(user)
    @status = Status.find(params[:id])

    # TODO - maybe return a JSONed status here already
    voter.upvote(@status)

    respond_with @status.as_json(user: user), location: nil
  end

end
