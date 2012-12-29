class StatusesController < ApplicationController
  # include ApplicationHelper
  respond_to :json

  def index
    if params[:ids]
      respond_with Status.find(params[:ids])
    else
      respond_with Timeline.for_user(current_user)
    end
  end

  def show
    respond_with Status.find(params[:id])
  end

  def create
    status = StatusCreator.create(params[:status], current_user)
    # TODO - figure out how to return a proper error here
    status.save
    respond_with status
  end

end
