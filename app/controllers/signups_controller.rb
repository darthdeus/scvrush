class SignupsController < ApplicationController

  respond_to :json

  def index
    respond_with Signup.find(params[:ids])
  end

end
