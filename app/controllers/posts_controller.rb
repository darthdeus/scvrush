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

  def create
    authorize! :create, Post
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: "Post draft was created, it needs to be published to be displayed for users"
    else
      render "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    authorize! :update, @post

    @post.update_attributes(params[:post])
    if @post.save
      redirect_to @post, notice: "Post was successfuly updated"
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
    redirect_to dashboard_path, notice: "Post removed"
  end

  def publish
    @post = Post.find(params[:id])
    authorize! :publish, Post

    begin
      @post.publish(params)
      @post.save!
      redirect_to dashboard_path, notice: "Post was #{(params[:published] == "1") ? "published" : "unpublished"}."
    rescue ArgumentError => e
      flash[:error] = e.message
      redirect_to dashboard_path
    end
  end

end
