class StatusesController < AuthenticatedController

  def create
    status = current_user.statuses.create(params[:status])
    redirect_to :back
  end

end
