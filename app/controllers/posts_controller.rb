class PostsController < ApplicationController
  before_filter :require_writer, :except => [:index, :tag, :show]

  def index
    @posts = Post.published.page(params[:page])

    respond_to do |format|
      format.html #{ fresh_when :etag => Digest::MD5.hexdigest(@posts.pluck(:updated_at).to_s), :public => true }
      format.rss { render :layout => false }
    end
  end

  def tag
    if params[:id]
      @posts = Post.published.page(params[:page]).tagged_with(params[:id])
      render :index
    else
      flash[:error] = "Tag doesn't exist"
      redirect_to :action => :index
    end
  end

  def show
    @post = Post.find(params[:id])
    # fresh_when @post, :public => true

    @comments = @post.comments
    @comment = Comment.new(:post => @post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to posts_path, :notice => "Post published"
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
    @image = Image.new
    @images = Image.last(5)
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.save
      redirect_to @post, :notice => "Post was successfuly updated"
    else
      @image = Image.new
      @images = Image.last(5)
      render "edit"
    end
  end

  def destroy
    Post.destroy(params[:id])
    redirect_to posts_path, :notice => "Post removed"
  end

end
