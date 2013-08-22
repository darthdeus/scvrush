class PostsController < AuthenticatedController

  def index
    respond_to do |format|
      format.html { @posts = PostSearch.new(params).search }
      format.rss { redirect_to posts_path(format: "atom") }
      format.atom { @posts = rss_posts; render layout: false }
    end
    @posts = PostSearch.new(params).search
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def rss_posts
    Post.published.limit(20)
  end

end
