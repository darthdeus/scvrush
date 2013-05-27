class Api::NotificationsController < ApplicationController

  def index
    render json: Notification.find(params[:ids])
  end

end
