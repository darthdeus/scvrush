class StatusesController < AuthenticatedController

  def create
    if current_user.statuses.create(params[:status])
      redirect_to :back, notice: "Status was posted!"
    else
      redirect_to :back, notice: "You can't post an empty status."
    end
  end

  def destroy
    current_user.statuses.find(params[:id]).destroy
    redirect_to :back, notice: "Status was deleted"
  end

end
