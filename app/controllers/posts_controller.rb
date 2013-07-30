class PostsController < AuthenticatedController

  def index
    @posts = Post.scoped

    if params[:query].present?
      @posts = @posts.search(params[:query], page: params[:page] || 1, load: true)
    else
      @posts = @posts.published.page(params[:page]).per(15)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

end
