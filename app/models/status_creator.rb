class StatusCreator

  def self.create(attributes, user)
    status = Status.new(attributes)

    # User is the author here, not the timeline
    # where it is displayed
    status.user_id  = user.id
    status.username = user.username
    status.avatar   = Digest::MD5.hexdigest(user.email)
    status
  end

end
