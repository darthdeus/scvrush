class Api::CoachesController < AuthenticatedController

  def index
    render json: Coach.all
  end

  def show
    render json: Coach.find(params[:id])
  end

end
