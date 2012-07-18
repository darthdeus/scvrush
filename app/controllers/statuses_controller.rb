class StatusesController < ApplicationController

  before_filter :require_login, only: [:create]
  respond_to :json

  def index
    @user = User.find(params[:user_id])
    respond_with @user.statuses.order("created_at DESC")
  end

  def create
    @status = current_user.statuses.new(params[:status])
    if @status.save
      flash[:success] = "Status was posted successfuly."
    else
      flash[:error] = "The status messsage can't be empty."
    end

    redirect_to current_user
  end

end
