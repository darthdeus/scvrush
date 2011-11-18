module PostsHelper
  def featured_image(post)
    unless post.featured_image
      image_tag "http://scvrush.com/wp-content/themes/Avenue/timthumb.php?src=http://scvrush.com/wp-content/themes/Avenue/images/thumbnail.png&w=100&h=100", :alt => "No image available"
    else
      base_url = "http://scvrush.superinzerce.com/wp-content/uploads/"
      img = image_tag(base_url + post.featured_image, :alt => post.featured_image)
      link_to img, post    
    end
  end
  
  def post_excerpt(content)
    content.force_encoding('utf-8').gsub(%r{</?[^>]+?>}, '').slice(0, 200) + " ..."
  end
end
