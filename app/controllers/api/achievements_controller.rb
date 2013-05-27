class Api::AchievementsController < ApplicationController

  def index
    render json: Tournament.find(params[:ids])
  end

end
