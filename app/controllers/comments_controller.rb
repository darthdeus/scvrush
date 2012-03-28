class CommentsController < ApplicationController
  before_filter :require_login, except: :index
  respond_to :json

  def index
    render json: Comment.where(post_id: params[:post_id]).includes(:user).map(&:to_simple_json)
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.save!
    render json: @comment.to_json(methods: [:author, :date])
  end

  def destroy
    current_user.comments.destroy(params[:id])
    render json: {status: 'ok'}
  end

end
