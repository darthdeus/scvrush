class VotesController < ApplicationController
  before_filter :require_login

  def create
    @comment = Comment.find(params[:id])
    current_user.vote_for(@comment)
    redirect_to post_path(@comment.post) + "#comments", :notice => "Voted scuccessfuly"
  end

  def destroy
    @comment = Comment.find(params[:id])
    current_user.clear_votes(@comment)
    redirect_to post_path(@comment.post_id) + "#comments", :notice => "Vote removed"
  end

end
