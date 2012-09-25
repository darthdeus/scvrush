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

  # Return an article icon for a given race
  def icon_for_race(race)
    case race
    when "protoss" then image_tag "race_protoss_icon.png"
    when "zerg"    then image_tag "race_zerg_icon.png"
    when "terran"  then image_tag "race_terran_icon.png"
    else
      raise "Invalid race parameter", ArgumentError
    end
  end

  def tournament_shortname(name)
    name.sub(/\[\w+\] /, '')
  end

  # Return a timezoned date for a given user,
  # or GMT if the user is nil.
  def nice_date(date, user)
    zone = (user && user.time_zone) ? user.time_zone : ActiveSupport::TimeZone.new("GMT")
    timezoned = date.in_time_zone(zone)
    res = format_time(timezoned)
    (user && user.time_zone) ? res : (res + " GMT")
  end

  def format_time(time)
    time.strftime("%A %b st, %l:%M%P").sub('st', time.day.ordinalize)
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
  # TODO - assign a designer to create a placeholder avatar customized for scvrush
  def author_avatar_for_post(post)
    if post.user.avatar?
      url = post.user.avatar.url(:thumb)
    else
      url = "https://s3.amazonaws.com/scvrush/uploads/post/featured_image/100x100_dark.png"
    end
    return image_tag(url)
  end

end
