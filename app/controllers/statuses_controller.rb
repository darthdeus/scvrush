class StatusesController < ApplicationController
  include ApplicationHelper
  before_filter :require_login, except: [:index]
  respond_to :json, :html

  def create
    @status = StatusCreator.create(params[:status], current_user)
    @status.save!
  end

  def destroy
    @status = Status.by(current_user.id).find(params[:id])
    @status.destroy
  end

  def like
    @status = Status.find(params[:id])
    @status.like(current_user.username)
    @status.save!
  end

end
