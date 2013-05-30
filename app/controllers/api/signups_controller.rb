class Api::SignupsController < ApplicationController

  def index
    render json: Signup.find(params[:ids])
  end

  def update
    signup = Signup.find(params[:id])
    if params[:signup][:status] === "checked"
      signup.checkin
    elsif params[:signup][:status] === "canceled"
      signup.cancel
    end

    render json: signup
  end

end
