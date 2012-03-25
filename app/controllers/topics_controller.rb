class TopicsController < ApplicationController
  before_filter :require_login, :only => :create

  def new
    @section = Section.find(params[:section_id])
    @topic = @section.topics.build
  end

  def show
    @topic = Topic.includes(:replies).find(params[:id])
    @replies = @topic.replies
    @reply = Reply.new(topic_id: @topic.id)
  end

  def create
    @section = Section.find(params[:topic][:section_id])
    @topic = Topic.new(params[:topic])
    @reply = Reply.new(params[:reply])
    @reply.topic = @topic
    @reply.user = current_user
    @topic.user = current_user
    if @topic.save && @reply.save
      redirect_to @topic, notice: "Topic was successfuly created."
    else
      logger.error @reply.errors.inspect
      logger.error @topic.errors.inspect
      render :new
    end
  end

end
