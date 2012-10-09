class StatusesController < ApplicationController

  before_filter :require_login, except: [:index]

  respond_to :json, :html

  def index
    id = params[:user_id]
    @user = id =~ /\d+(-.+)?/ ? User.find(id) : User.find_by_username(id)

    @statuses = Status.where(username: @user.username)
  end

  def create
    @status = current_user.statuses.create(params[:status])
    Rails.logger.error @status
    Rails.logger.error @status.errors.inspect
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
    voter = VoterDecorator.new(current_user)
    @status = Status.find(params[:id])

    # TODO - maybe return a JSONed status here already
    voter.upvote(@status)

    respond_with @status.as_json(user: current_user), location: nil
  end

end
