class StatusCreator

  def self.create(attributes, user)
    # TODO - pass the whole params and also check for timeline_id
    status = Status.new(attributes)

    # User is the author here, not the timeline
    # where it is displayed
    status.user_id  = user.id
    status
  end

end
