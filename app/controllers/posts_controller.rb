class PostsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]

  def index
    @posts = Post.recent
  end

  def show
    redirect_to posts_path, :notice => "Test redirect"
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    # @category = Category.new
    # @categories = Category.all
  end

  def create
    @post = Post.new(params[:Post])
    @category = Category.find(@Post.category)
    if @post.save
      redirect_to posts_path, :notice => "Post published"
    else
      render "new"
    end
  end
  
  def destroy
    Post.destroy(params[:id])
    redirect_to posts_path, :notice => "Post removed"
  end
end
