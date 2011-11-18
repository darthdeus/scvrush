class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
    @replies = @topic.replies
  end

end
