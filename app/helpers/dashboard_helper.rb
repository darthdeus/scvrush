module DashboardHelper
  def publish_post_link(post)
    if post.status == Post::DRAFT
      link_to 'publish', publish_post_path(post, published: 1), method: :post
    else
      link_to 'unpublish', publish_post_path(post, published: 0), method: :post
    end
  end

end
