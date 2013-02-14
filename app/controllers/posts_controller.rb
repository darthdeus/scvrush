class PostsController < ApplicationController
  respond_to :json

  def index
    if params[:query]
      posts = Post.search(params[:query], load: true).to_a
    else
      posts = Post.published.first(20)
    end

    render json: posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

end
