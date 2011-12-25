module PostsHelper
  def featured_image(post)
    img = image_tag post.featured_image_url(:thumb), :alt => post.title
    link_to img, post
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

  def tournament_shortname(name)
    name.sub(/\[\w+\] /, '')
  end

  def nice_date(date)
    date.strftime("%A %b %est, %l%P GMT")
  end
end
