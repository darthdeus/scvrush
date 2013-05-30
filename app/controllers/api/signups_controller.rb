class Api::SignupsController < ApplicationController

  def index
    render json: Signup.find(params[:ids])
  end

  def create
    signup = Signup.new(params[:signup])
    signup.status = Signup::REGISTERED
    signup.save

    render json: signup
  end

  def update
    signup = Signup.find(params[:id])
    if params[:signup][:status] === "checked"
      signup.checkin
    end

    render json: signup
  end

  def destroy
    signup = Signup.find(params[:id])
    signup.destroy

    render json: signup
  end

end
