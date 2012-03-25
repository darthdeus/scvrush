class PostsController < ApplicationController
  # before_filter :require_writer, :except => [:index, :tag, :show]

  def index
    @posts = Post.published.page(params[:page])

    respond_to do |format|
      format.html
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


    respond_to do |format|
      format.html do
        @comments = @post.comments
        @comment = Comment.new(:post => @post)
      end
      format.json { render json: @post }
    end
  end

  def new
    authorize! :create, Post
    @post = Post.new
  end

  def create
    authorize! :create, Post
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
    authorize! :update, @post

    @image = Image.new
    @images = Image.last(5)
  end

  def update
    @post = Post.find(params[:id])
    authorize! :update, @post

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
    @post = Post.find(params[:id])
    authorize! :destroy, @post

    @post.destroy
    redirect_to dashboard_path, :notice => "Post removed"
  end

  def publish
    @post = Post.find(params[:id])
    authorize! :publish, Post

    if params[:published] == "1"
      @post.status = Post::PUBLISHED
      begin
        @post.published_at = Time.parse("#{params[:date]} #{params[:time]}")
      rescue ArgumentError
        redirect_to dashboard_path, notice: "Invalid date or time format"
        return
      end
    elsif params[:published] == "0"
      @post.status = Post::DRAFT
    else
      raise "Invalid published status '#{params[:published].inspect}'"
    end

    @post.save!
    redirect_to dashboard_path, notice: "Post was #{(params[:published] == "1") ? "published" : "unpublished"}."
  end

end
