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

  def nice_date(date)
    date.strftime("%A %b st, %l:%M%P GMT").sub('st', date.day.ordinalize)
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
    link_to 'upvote',
      { :controller => :votes, :action => :create, :id => comment.id },
      :method => :post
  end

  def downvote_link(comment)
    link_to 'remove vote',
      { :controller => :votes, :action => :destroy, :id => comment.id },
      :method => :delete
  end

  def tag_by_name(name)
    link_to name, "/posts/tag/#{name}"
  end

  def strip_markdown(md)
    md.gsub(/[\[\]#*]/, '').gsub(/\(.*\)/, '')
  end
end
