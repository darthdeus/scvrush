class PostsController < ApplicationController
  before_filter :require_login, :except => [:index, :show, :tag]

  def index
    @posts = Post.recent.page(params[:page])
  end
  
  def tag
    if params[:id]
      @posts = Post.page(params[:page]).tagged_with(params[:id])
      render :index
    else
      flash[:error] = "Tag doesn't exist"
      redirect_to :action => :index
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new(:post => @post)
  end

  def new
    @post = Post.new
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
