class TopicsController < ApplicationController
  before_filter :require_login, :only => :create

  def index
    @section = Section.find(params[:section_id])
    respond_to do |format|
      format.json { render json: @section.topics.order("created_at DESC") }
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
    topic = Section.create_first_topic(params, current_user)

    if topic
      render json: { status: :ok, location: topic_path(topic) }
    else
      render json: { status: :error, type: :validation  }
    end
  end

end
