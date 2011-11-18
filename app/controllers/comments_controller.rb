class CommentsController < ApplicationController
  before_filter :require_login
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@comment.post_id), :notice => "Your comment was successfuly submitted."
    else
      redirect_to post_path(@comment.post_id), :error => "Unable to post comment due to error. #{@comment.errors}"
    end
  end

end
