class Api::CoachesController < AuthenticatedController

  def index
    if params[:race]
      coaches = Coach.where("? = ANY(races)", params[:race])
      coaches.limit(params[:limit]) if params[:limit]

      render json: coaches
    else
      render json: Coach.all
    end
  end

  def show
    render json: Coach.find(params[:id])
  end

end
