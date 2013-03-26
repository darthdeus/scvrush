class Timeline

  def self.for_user(user)
    Status.where(user_id: user.following_ids << user.id)
  end

end

