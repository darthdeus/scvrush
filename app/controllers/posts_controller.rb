class PostsController < ApplicationController
  respond_to :json

  def index
    posts = Post.scoped

    if params[:query].present?
      posts = posts.search(params[:query], page: params[:page] || 1, load: true)
    else #if params[:page]
      posts = posts.published.page(params[:page]).per(15)
    end

    render json: posts.to_a
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

end
