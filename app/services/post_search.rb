class PostSearch < Struct.new(:params)
  def search
    posts = Post.all

    if params[:query].present?
      posts = posts.search(params[:query], page: params[:page] || 1, load: true)
    else
      posts = posts.published.page(params[:page]).per_page(15)
    end

    posts
  end
end
