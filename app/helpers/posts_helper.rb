module PostsHelper
  def featured_image(post)
    img = image_tag post.featured_image_url(:thumb), :alt => post.title
    link_to img, post
  end

  def post_excerpt(content, length = 200)
    strip_markdown(content.force_encoding('utf-8').gsub(%r{</?[^>]+?>}, '')).slice(0, length) + " ..."
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

  def nice_date(date, user)
    timezoned = date
    if user && user.time_zone
      timezoned = date.in_time_zone(user.time_zone)
    end
    timezoned.strftime("%A %b st, %l:%M%P").sub('st', timezoned.day.ordinalize)
  end

  def vote_link(user, comment)
    if comment.user == user
      "" # no link for your own comment
    elsif user.voted_on?(comment)
      downvote_link(comment)
    else
      upvote_link(comment)
    end
  end

  def upvote_link(comment)
    link_to :controller => :votes, :action => :create, :id => comment.id do
      "<i class='icon-ok'></i>".html_safe
    end
  end

  def downvote_link(comment)
    link_to "<i class='icon-remove'></i>",
      { :controller => :votes, :action => :destroy, :id => comment.id },
      :method => :delete
  end

  def tag_by_name(name)
    link_to name.gsub('-', ' '), "/posts/tag/#{name}"
  end

  def strip_markdown(md)
    md.gsub(/[\[\]#*]/, '').gsub(/\(.*\)/, '')
  end


  # Return an image tag for post author's avatar,
  # or just return a default SCV Rush avatar if the user
  # doesn't have one.
  #
  # TODO - assign a designer to create a placeholder avatar
  # customized for scvrush
  def author_avatar_for_post(post)
    if post.user.avatar?
      url = post.user.avatar.url(:thumb)
    else
      url = "https://s3.amazonaws.com/scvrush/uploads/post/featured_image/100x100_dark.png"
    end
    return image_tag(url)
  end

end
