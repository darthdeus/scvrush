module TopicsHelper

  def vote_link(user, reply)
    if reply.user == user
      "" # no link for your own reply
    elsif user.voted_on?(reply)
      downvote_link(reply)
    else
      upvote_link(reply)
    end
  end

  def upvote_link(reply)
    link_to 'upvote',
      { :controller => :reply_votes, :action => :create, :id => reply.id },
      :method => :post
  end

  def downvote_link(reply)
    link_to 'remove vote',
      { :controller => :reply_votes, :action => :destroy, :id => reply.id },
      :method => :delete
  end
end
