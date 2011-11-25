module PostsHelper
  def featured_image(post)
    unless post.featured_image
      image_tag "http://scvrush.superinzerce.com/wp-content/themes/Avenue/timthumb.php?src=http://scvrush.superinzerce.com/wp-content/themes/Avenue/images/thumbnail.png&w=100&h=100", :alt => "No image available"
    else
      # base_url = "https://s3.amazonaws.com/scvrush/pictures/"
      # img = image_tag(base_url + post.featured_image, :alt => post.featured_image)
      img = image_tag post.featured_image_url(:thumb), :alt => post.title
      link_to img, post    
    end
  end
  
  def post_excerpt(content, length = 200)
    content.force_encoding('utf-8').gsub(%r{</?[^>]+?>}, '').slice(0, length) + " ..."
  end
  
  def shortenify(title, length = 30)
    if title.length > length
      title.slice(0, length) + " ..."
    else
      title
    end
  end
end
