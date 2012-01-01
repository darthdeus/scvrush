class CommentsController < ApplicationController
  before_filter :require_login

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@comment.post_id) + "#comments", :notice => "Your comment was successfuly submitted."
    else
      redirect_to post_path(@comment.post_id) + "#comments", :notice => "You can't post an empty comment! Try again and write at least 10 characters this time."
    end
  end

end
