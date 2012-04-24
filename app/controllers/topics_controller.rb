class TopicsController < ApplicationController
  before_filter :require_login, :only => :create

  def index
    @section = Section.find(params[:section_id])
    respond_to do |format|
      format.json { render json: @section.topics }
    end
  end

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
    ActiveRecord::Base.transaction do
      @section = Section.find(params[:section_id])
      @topic = @section.topics.create({
        name: params[:topic][:name],
        user_id: current_user.id
      })

      @reply = Reply.create({
        content: params[:topic][:content],
        topic_id: @topic.id,
        user_id: current_user.id
      })

      # TODO - add more information here
      render json: [@topic, @reply]
    end
  end

end
