class PostsController < AuthenticatedController

  def index
    @posts = Post.limit(15)
  end

  def show
    @post = Post.find(params[:id])
  end

end
