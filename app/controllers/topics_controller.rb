class TopicsController < ApplicationController
  def show
    # fix 1+N here
    @topic = Topic.find(params[:id])
    @replies = @topic.replies
  end

end
