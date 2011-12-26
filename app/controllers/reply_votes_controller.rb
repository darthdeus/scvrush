class ReplyVotesController < ApplicationController
  before_filter :require_login

  def create
    @reply = Reply.find(params[:id])
    if @reply.user == current_user
      redirect_to :back, :notice => "You can't vote on your own reply!"
    else
      current_user.vote_for(@reply)
      redirect_to topic_path(@reply.topic_id) + "#replies", :notice => "Voted scuccessfuly"
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    current_user.clear_votes(@reply)
    redirect_to topic_path(@reply.topic_id) + "#replys", :notice => "Vote removed"
  end

end
