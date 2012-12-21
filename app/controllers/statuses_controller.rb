class StatusesController < ApplicationController
  # include ApplicationHelper
  respond_to :json

  def index
    if params[:ids]
      respond_with Status.find(params[:ids])
    else
      respond_with Status.first(20)
    end
  end

  def show
    respond_with Status.find(params[:id])
  end

  # def create
  #   @status = StatusCreator.create(params[:status], current_user)
  #   @status.save!
  # end

  # def destroy
  #   @status = Status.by(current_user.id).find(params[:id])
  #   @status.destroy
  # end

  # def like
  #   @status = Status.find(params[:id])
  #   @status.like(current_user.username)
  #   @status.save!
  # end

end
