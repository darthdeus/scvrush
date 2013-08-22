atom_feed language: "en-US" do |feed|
  feed.title "SCV Rush - Recent Articles"
  feed.updated @posts.first.updated_at

  @posts.each do |post|
    next if post.updated_at.blank?

    feed.entry(post) do |entry|
      entry.url post_url(post)
      entry.title post.title
      entry.content post.content, type: "html"

      # the strftime is needed to work with Google Reader.
      entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name post.author_name
      end
    end
  end
end
