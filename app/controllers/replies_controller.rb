class RepliesController < ApplicationController
  before_filter :require_login, :only => :create  
  
  def create
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "Reply posted successfuly."
    else
      flash[:error] = "You can't post an empty reply!"
    end
    redirect_to topic_path(@reply.topic_id)      
  end

end
