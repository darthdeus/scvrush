class StatusesController < ApplicationController
  # include ApplicationHelper
  respond_to :json

  def index
    if params[:ids]
      render json: Status.find(params[:ids])
    else
      render json: Timeline.for_user(current_user)
    end
  end

  def show
    render json: Status.find(params[:id])
  end

  def create
    status = Status.new(params[:status])
    status.user_id = current_user.id

    status.save!
    render json: status
  end

  def destroy
    status = Status.find(params[:id])
    status.destroy
    render json: nil, status: :ok
  end

end
