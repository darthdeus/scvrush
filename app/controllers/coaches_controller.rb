class CoachesController < AuthenticatedController

  def index
    @coaches = Coach.all.group_by { |coach| coach.servers.first}
  end

  def show
    @coach = Coach.find(params[:id])
  end

end
