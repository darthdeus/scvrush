class RepliesController < ApplicationController
  before_filter :require_login, :only => :create

  respond_to :json
  
  def index
    # TODO - test this
    respond_with Reply.for_topic(params[:topic_id])
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    @reply.save!
    render json: @reply.to_simple_json
  end

end
