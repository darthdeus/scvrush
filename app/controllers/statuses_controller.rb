class StatusesController < ApplicationController

  before_filter :require_login

  def create
    @status = current_user.statuses.new(params[:status])
    if @status.save
      flash[:success] = "Status was posted successfuly."
    else
      flash[:error] = "The status messsage can't be empty."
    end

    redirect_to current_user
  end

end
