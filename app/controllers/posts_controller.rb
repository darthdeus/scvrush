class PostsController < ApplicationController
  before_filter :require_login, :except => :index

  def index
    @posts = Post.all
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
      redirect_to Posts_path, :notice => "Post published"
    else
      render "new"
    end
  end
  
  def destroy
    Post.destroy(params[:id])
    redirect_to Posts_path, :notice => "Post removed"
  end
end
