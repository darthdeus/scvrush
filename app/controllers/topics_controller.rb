class TopicsController < ApplicationController
  before_filter :require_login, :only => :create

  def show
    # fix 1+N here
    @topic = Topic.find(params[:id])
    @replies = @topic.replies
    @reply = Reply.new(:topic_id => @topic.id)
  end
  
  def create
    @topic = Topic.new(params[:topic])
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    @topic.user = current_user
    if @topic.save && @reply.save
      redirect_to @topic, :notice => "Topic was successfuly created."
    else
      render :new
    end
  end  

end
