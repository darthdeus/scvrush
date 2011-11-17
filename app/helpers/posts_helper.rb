module PostsHelper
  def featured_image(post)
    base_url = "http://scvrush.superinzerce.com/wp-content/uploads/"
    img = image_tag(base_url + post.featured_image, :alt => post.featured_image)
    link_to img, post    
  end
  
  def post_excerpt(content)
    content.force_encoding('utf-8').gsub(%r{</?[^>]+?>}, '').slice(0, 200) + " ..."
  end
end
