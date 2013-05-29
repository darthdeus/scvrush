class Api::SignupsController < ApplicationController

  def index
    render json: Signup.find(params[:ids])
  end

end
